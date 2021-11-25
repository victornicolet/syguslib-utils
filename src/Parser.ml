open Base
open Sexplib
open Sygus

let symbol_of_sexp (s : Sexp.t) : symbol =
  match s with
  | Atom symb -> symb
  | _ -> failwith (Fmt.str "%a is not a symbol" Sexp.pp_hum s)
;;

let index_of_sexp (s : Sexp.t) : index =
  match s with
  | Atom s ->
    (match Caml.int_of_string_opt s with
    | Some i -> INum i
    | None -> ISym s)
  | _ -> failwith "Not an index"
;;

let identifier_of_sexp (s : Sexp.t) : identifier =
  match s with
  | Atom name -> if valid_ident name then IdSimple name else failwith "Not an identifier."
  | List (Atom "_" :: main_s :: i0 :: indexes) ->
    IdIndexed (symbol_of_sexp main_s, List.map ~f:index_of_sexp (i0 :: indexes))
  | _ -> failwith "Not an identifier."
;;

let rec sygus_sort_of_sexp (s : Sexp.t) : sygus_sort =
  try SId (identifier_of_sexp s) with
  | _ ->
    (match s with
    | List (id :: s1 :: sygus_sorts) ->
      SApp (identifier_of_sexp id, List.map ~f:sygus_sort_of_sexp (s1 :: sygus_sorts))
    | _ -> failwith "Not a sygus_sort")
;;

let sorted_var_of_sexp (s : Sexp.t) : sorted_var =
  match s with
  | List [ symb; sygus_sort ] -> symbol_of_sexp symb, sygus_sort_of_sexp sygus_sort
  | _ -> failwith (Fmt.str "Not a sygus_sorted var: %a" Sexp.pp_hum s)
;;

let literal_of_string (s : string) : literal =
  if String.is_prefix ~prefix:"\"" s
  then LitString s
  else if String.is_prefix ~prefix:"#x" s
  then LitHex (String.chop_prefix_exn ~prefix:"#x" s)
  else if String.is_prefix ~prefix:"#b" s
  then (
    let b = String.chop_prefix_exn ~prefix:"#b" s in
    LitBin (List.map ~f:char_to_bool (String.to_list b)))
  else (
    match s with
    | "true" -> LitBool true
    | "false" -> LitBool false
    | _ ->
      (match Caml.int_of_string_opt s with
      | Some i -> LitNum i
      | None ->
        (match Caml.float_of_string_opt s with
        | Some f -> LitDec f
        | None -> failwith "Not a literal.")))
;;

let literal_of_sexp (s : Sexp.t) : literal =
  match s with
  | Atom atom -> literal_of_string atom
  | _ -> failwith "not a literal"
;;

let rec sygus_term_of_sexp (s : Sexp.t) : sygus_term =
  match s with
  | List [ Atom "exists"; List _vars; sygus_term ] ->
    SyExists (List.map ~f:sorted_var_of_sexp _vars, sygus_term_of_sexp sygus_term)
  | List [ Atom "forall"; List _vars; sygus_term ] ->
    SyForall (List.map ~f:sorted_var_of_sexp _vars, sygus_term_of_sexp sygus_term)
  | List [ Atom "let"; List bindings; sygus_term ] ->
    SyLet (List.map ~f:binding_of_sexp bindings, sygus_term_of_sexp sygus_term)
  | List (hd :: tl) -> SyApp (identifier_of_sexp hd, List.map ~f:sygus_term_of_sexp tl)
  | _ ->
    (try SyLit (literal_of_sexp s) with
    | _ -> SyId (identifier_of_sexp s))

and binding_of_sexp (s : Sexp.t) : binding =
  match s with
  | List [ symb; sygus_term ] -> symbol_of_sexp symb, sygus_term_of_sexp sygus_term
  | _ -> failwith "not a binding"
;;

let feature_of_sexp (s : Sexp.t) : feature =
  match s with
  | Atom "grammars" -> FGrammar
  | Atom "fwd-decls" -> FFwdDecls
  | Atom "recursion" -> FRecursion
  | _ -> failwith "Not a feature."
;;

let sygus_sort_decl_of_sexp (s : Sexp.t) : sygus_sort_decl =
  match s with
  | List [ symb; Atom num ] -> symbol_of_sexp symb, Int.of_string num
  | _ -> failwith "Not a sygus_sort declaration."
;;

let dt_cons_dec_of_sexp (s : Sexp.t) : dt_cons_dec =
  match s with
  | List (symb :: args) -> symbol_of_sexp symb, List.map ~f:sorted_var_of_sexp args
  | _ -> failwith "Not a data constructor declaration."
;;

let dt_cons_dec_list_of_sexp (s : Sexp.t) : dt_cons_dec list =
  match s with
  | List (d1 :: drest) -> List.map ~f:dt_cons_dec_of_sexp (d1 :: drest)
  | _ -> failwith "Not a list+ of data constructor declarations."
;;

let sygus_sort_decl_list_of_sexp (s : Sexp.t) : sygus_sort_decl list =
  match s with
  | List (sd1 :: sdrest) -> List.map ~f:sygus_sort_decl_of_sexp (sd1 :: sdrest)
  | _ -> failwith "Not a list+ of sygus_sort declarations."
;;

let sygus_gsterm_of_sexp (s : Sexp.t) : sygus_gsterm =
  match s with
  | List [ Atom "Constant"; sygus_sort ] -> GConstant (sygus_sort_of_sexp sygus_sort)
  | List [ Atom "Variable"; sygus_sort ] -> GVar (sygus_sort_of_sexp sygus_sort)
  | t ->
    (try GTerm (sygus_term_of_sexp t) with
    | _ -> failwith (Fmt.str "Not a grammar sygus_term (%a)" Sexp.pp s))
;;

let pre_grouped_rule_of_sexp (s : Sexp.t) =
  match s with
  | List [ name; sygus_sort; List gramsygus_terms ] ->
    ( symbol_of_sexp name
    , sygus_sort_of_sexp sygus_sort
    , List.map ~f:sygus_gsterm_of_sexp gramsygus_terms )
  | _ -> failwith "Not a grouped rule."
;;

let grammar_def_of_sexps (sv : Sexp.t) (gr : Sexp.t) : grammar_def =
  match sv, gr with
  | List sygus_sorts, List grouped_rules ->
    (match
       List.zip
         (List.map ~f:sorted_var_of_sexp sygus_sorts)
         (List.map ~f:pre_grouped_rule_of_sexp grouped_rules)
     with
    | Ok l -> List.map ~f:(fun (s, (_, _, g)) -> s, g) l
    | _ -> failwith "Not a grammar definition.")
  | _ -> failwith "Not a grammar definition."
;;

let command_of_sexp (s : Sexp.t) : command =
  let command_of_elts (sl : Sexp.t list) : command =
    match sl with
    | [ Atom single ] ->
      (match single with
      | "check-synth" -> CCheckSynth
      | _ -> failwith (Fmt.str "Not a command: %a." Sexp.pp_hum s))
    | [ Atom com_name; arg ] ->
      (match com_name with
      | "constraint" -> CConstraint (sygus_term_of_sexp arg)
      | "set-logic" -> CSetLogic (symbol_of_sexp arg)
      | _ -> failwith (Fmt.str "Not a command: %a." Sexp.pp_hum s))
    | [ Atom "synth-inv"; name; List args ] ->
      CSynthInv (symbol_of_sexp name, List.map ~f:sorted_var_of_sexp args, None)
    | [ Atom "synth-fun"; name; List args; res ] ->
      CSynthFun
        ( symbol_of_sexp name
        , List.map ~f:sorted_var_of_sexp args
        , sygus_sort_of_sexp res
        , None )
    | [ Atom com_name; arg1; arg2 ] ->
      (match com_name with
      | "declare-var" -> CDeclareVar (symbol_of_sexp arg1, sygus_sort_of_sexp arg2)
      | "declare-datatype" ->
        CDeclareDataType (symbol_of_sexp arg1, dt_cons_dec_list_of_sexp arg2)
      | "declare-datatypes" ->
        (match arg2 with
        | List args2 ->
          let decls_l = sygus_sort_decl_list_of_sexp arg1 in
          let dt_const = List.map ~f:dt_cons_dec_list_of_sexp args2 in
          CDeclareDataTypes (decls_l, dt_const)
        | _ -> failwith "Not a proper datatypes-declaration.")
      | "declare-sort" -> CDeclareSort (symbol_of_sexp arg1, Int.t_of_sexp arg2)
      | "define-sort" -> CDefineSort (symbol_of_sexp arg1, sygus_sort_of_sexp arg2)
      | _ -> failwith (Fmt.str "Not a command: %a." Sexp.pp_hum s))
    | [ Atom com_name; Atom ":"; arg1; arg2 ] ->
      (match com_name with
      | "set-info" -> CSetInfo (symbol_of_sexp arg1, literal_of_sexp arg2)
      | "set-option" -> CSetOption (symbol_of_sexp arg1, literal_of_sexp arg2)
      | "set-feature" -> CSetFeature (feature_of_sexp arg1, bool_of_sexp arg2)
      | _ -> failwith (Fmt.str "Not a command: %a." Sexp.pp_hum s))
    | [ Atom "define-fun"; name; List args; res; body ] ->
      CDefineFun
        ( symbol_of_sexp name
        , List.map ~f:sorted_var_of_sexp args
        , sygus_sort_of_sexp res
        , sygus_term_of_sexp body )
    | [ Atom "synth-inv"; name; List args; gd1; gd2 ] ->
      CSynthInv
        ( symbol_of_sexp name
        , List.map ~f:sorted_var_of_sexp args
        , Some (grammar_def_of_sexps gd1 gd2) )
    | [ Atom "synth-fun"; name; List args; res; gd1; gd2 ] ->
      CSynthFun
        ( symbol_of_sexp name
        , List.map ~f:sorted_var_of_sexp args
        , sygus_sort_of_sexp res
        , Some (grammar_def_of_sexps gd1 gd2) )
    | [ Atom "inv-constraint"; a; b; c; d ] ->
      CInvConstraint
        (symbol_of_sexp a, symbol_of_sexp b, symbol_of_sexp c, symbol_of_sexp d)
    | _ -> failwith (Fmt.str "Not a command: %a." Sexp.pp_hum s)
  in
  match s with
  | List elts -> command_of_elts elts
  | _ -> failwith (Fmt.str "Not a command: %a." Sexp.pp_hum s)
;;

let program_of_sexp_list (sexps : Sexp.t list) : program =
  List.map ~f:command_of_sexp sexps
;;

let reponse_of_sexps (s : Sexp.t list) : solver_response =
  let atomic_response (s : Sexp.t list) =
    match s with
    | [ Atom "fail" ] -> Some RFail
    | [ Atom "infeasible" ] -> Some RInfeasible
    | [ Atom "unknown" ] -> Some RUnknown
    | [ Atom "sat" ] -> Some RInfeasible
    | _ -> None
  in
  let one_command cmd =
    try
      match command_of_sexp cmd with
      | CDefineFun (f, args, res, body) -> Some [ f, args, res, body ]
      | _ -> None
    with
    | Failure _ -> None
  in
  let success_response s =
    RSuccess
      (List.concat
         (List.filter_map s ~f:(function
             | Sexp.Atom "unsat" -> None (* Ignore 'unsat' printed by CVC4. *)
             | Sexp.List l as cmd ->
               (match one_command cmd with
               (* A response composed of a single command. *)
               | Some s -> Some s
               | None ->
                 (match Option.all (List.map ~f:one_command l) with
                 | Some defs -> Some (List.concat defs)
                 | None -> None))
             | Sexp.Atom _ -> None)))
  in
  match atomic_response s with
  | Some r -> r
  | None -> success_response s
;;
