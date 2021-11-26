open Base
open Sexplib
open Sygus

exception ParseError of Sexp.t * string
exception NonConforming of command * string

let raise_parse_error (s : Sexp.t) (msg : string) = raise (ParseError (s, msg))
let raise_nonconforming (s : command) (msg : string) = raise (NonConforming (s, msg))

let symbol_of_sexp (s : Sexp.t) : symbol =
  match s with
  | Atom symb -> symb
  | _ -> raise_parse_error s "Not a symbol"
;;

let keyword_of_sexp (s : Sexp.t) : string option =
  match s with
  | Atom kw -> String.chop_prefix ~prefix:":" kw
  | _ -> None
;;

let feature_of_sexp (s : Sexp.t) : (feature, string) Result.t =
  match keyword_of_sexp s with
  | Some "grammar" -> Ok FGrammar
  | Some "fwd-decls" -> Ok FFwdDecls
  | Some "recursion" -> Ok FRecursion
  | Some "oracles" -> Ok FOracles
  | Some "weights" -> Ok FWeights
  | _ -> raise_parse_error s "Not a valid feature"
;;

let attributes_of_sexps (sl : Sexp.t list) : (attribute list, string) Result.t =
  let f (l, p) atom =
    match atom with
    | Sexp.Atom x when String.length x > 0 ->
      (match keyword_of_sexp (Atom x) with
      | Some attr_name ->
        (match p with
        | Some key -> Continue_or_stop.Continue (Attr key :: l, Some attr_name)
        | None -> Continue (l, Some attr_name))
      | None ->
        (match p with
        | Some key -> Continue (AttrVal (key, x) :: l, None)
        | None -> Stop (Error "A lone value in a list of attributes.")))
    | _ -> Stop (Error "Attributes can only use atoms.")
  in
  List.fold_until ~init:([], None) ~f sl ~finish:(function
      | l, Some v -> Ok (List.rev (Attr v :: l))
      | l, None -> Ok (List.rev l))
;;

let index_of_sexp (s : Sexp.t) : index =
  match s with
  | Atom s ->
    (match Caml.int_of_string_opt s with
    | Some i -> INum i
    | None -> ISym s)
  | _ -> raise_parse_error s "Not an index"
;;

let identifier_of_sexp (s : Sexp.t) : identifier =
  match s with
  | Atom name ->
    if valid_ident name
    then IdSimple name
    else raise_parse_error s (Fmt.str "%s is not an identifier." name)
  | List (Atom "_" :: main_s :: i0 :: indexes) ->
    IdIndexed (symbol_of_sexp main_s, List.map ~f:index_of_sexp (i0 :: indexes))
  | _ -> raise_parse_error s "Not an identifier."
;;

let rec sygus_sort_of_sexp (s : Sexp.t) : sygus_sort =
  try SId (identifier_of_sexp s) with
  | _ ->
    (match s with
    | List (id :: s1 :: sygus_sorts) ->
      SApp (identifier_of_sexp id, List.map ~f:sygus_sort_of_sexp (s1 :: sygus_sorts))
    | _ -> raise_parse_error s "Not a sygus_sort")
;;

let sorted_var_of_sexp (s : Sexp.t) : sorted_var =
  match s with
  | List [ symb; sygus_sort ] -> symbol_of_sexp symb, sygus_sort_of_sexp sygus_sort
  | _ -> raise_parse_error s "Not a sygus_sorted var."
;;

let literal_of_string (s : string) : literal =
  if String.is_empty s
  then LitString s
  else if String.is_prefix ~prefix:"\"" s
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
        | None -> raise_parse_error (Atom s) "Not a literal.")))
;;

let literal_of_sexp (s : Sexp.t) : literal =
  match s with
  | Atom atom -> literal_of_string atom
  | _ -> raise_parse_error s "Not a literal."
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
    | _ ->
      (try SyId (identifier_of_sexp s) with
      | ParseError (s, msg) -> raise_parse_error s (msg ^ "(while parsing a term)")))

and binding_of_sexp (s : Sexp.t) : binding =
  match s with
  | List [ symb; sygus_term ] -> symbol_of_sexp symb, sygus_term_of_sexp sygus_term
  | _ -> raise_parse_error s "not a binding"
;;

let sygus_sort_decl_of_sexp (s : Sexp.t) : sygus_sort_decl =
  match s with
  | List [ symb; Atom num ] -> symbol_of_sexp symb, Int.of_string num
  | _ -> raise_parse_error s "Not a sygus_sort declaration."
;;

let dt_cons_dec_of_sexp (s : Sexp.t) : dt_cons_dec =
  match s with
  | List (symb :: args) -> symbol_of_sexp symb, List.map ~f:sorted_var_of_sexp args
  | _ -> raise_parse_error s "Not a data constructor declaration."
;;

let dt_cons_dec_list_of_sexp (s : Sexp.t) : dt_cons_dec list =
  match s with
  | List (d1 :: drest) -> List.map ~f:dt_cons_dec_of_sexp (d1 :: drest)
  | _ -> raise_parse_error s "Not a list+ of data constructor declarations."
;;

let sygus_sort_decl_list_of_sexp (s : Sexp.t) : sygus_sort_decl list =
  match s with
  | List (sd1 :: sdrest) -> List.map ~f:sygus_sort_decl_of_sexp (sd1 :: sdrest)
  | _ -> raise_parse_error s "Not a list+ of sygus_sort declarations."
;;

let sygus_gsterm_of_sexp (s : Sexp.t) : sygus_gsterm =
  match s with
  | List [ Atom "Constant"; sygus_sort ] -> GConstant (sygus_sort_of_sexp sygus_sort)
  | List [ Atom "Variable"; sygus_sort ] -> GVar (sygus_sort_of_sexp sygus_sort)
  | t ->
    (try GTerm (sygus_term_of_sexp t) with
    | ParseError (s, msg) ->
      raise_parse_error s (msg ^ "(while parsing a sygus grammar term)"))
;;

let pre_grouped_rule_of_sexp (s : Sexp.t) =
  match s with
  | List [ name; sygus_sort; List gramsygus_terms ] ->
    ( symbol_of_sexp name
    , sygus_sort_of_sexp sygus_sort
    , List.map ~f:sygus_gsterm_of_sexp gramsygus_terms )
  | _ -> raise_parse_error s "Not a grouped rule."
;;

let grammar_def_of_sexps (sv : Sexp.t option) (gr : Sexp.t) : grammar_def =
  match sv, gr with
  | Some (List sygus_sorts), List grouped_rules ->
    (match
       List.zip
         (List.map ~f:sorted_var_of_sexp sygus_sorts)
         (List.map ~f:pre_grouped_rule_of_sexp grouped_rules)
     with
    | Ok l -> List.map ~f:(fun (s, (_, _, g)) -> s, g) l
    | _ ->
      raise_parse_error
        (List [ List sygus_sorts; gr ])
        "Number of non-terminal symbols and grammar rules do not match.")
  | None, List grouped_rules ->
    let l = List.map ~f:pre_grouped_rule_of_sexp grouped_rules in
    List.map ~f:(fun (s, t, g) -> (s, t), g) l
  | _ -> raise_parse_error (List [ gr ]) "Not a grammar definition."
;;

let command_of_sexp (s : Sexp.t) : command =
  let command_of_elts (cn : string) (sl : Sexp.t list) : (command, string) Result.t =
    match cn with
    | "assume" ->
      (match sl with
      | [ a ] -> Ok (CAssume (sygus_term_of_sexp a))
      | _ -> Error "assume accepts exactly one argument.")
    | "check-synth" ->
      (match sl with
      | [] -> Ok CCheckSynth
      | _ -> Error "check-synth should not have any arguments.")
    | "chc-constraint" ->
      (match sl with
      | [ List svars; t1; t2 ] ->
        Ok
          (CChcConstraint
             ( List.map ~f:sorted_var_of_sexp svars
             , sygus_term_of_sexp t1
             , sygus_term_of_sexp t2 ))
      | _ -> Error "wrong number of arguments for chc-constraint.")
    | "constraint" ->
      (match sl with
      | [ a ] -> Ok (CConstraint (sygus_term_of_sexp a))
      | _ -> Error "constraint should have only one term as input.")
    | "declare-var" ->
      (match sl with
      | [ vname; sort ] ->
        Ok (CDeclareVar (symbol_of_sexp vname, sygus_sort_of_sexp sort))
      | _ -> Error "declare-var should have only one symbol and one sort as arguments.")
    | "declare-weight" ->
      (match sl with
      | symb :: attributes ->
        Result.(
          attributes_of_sexps attributes
          >>| fun attrs -> CDeclareWeight (symbol_of_sexp symb, attrs))
      | _ -> Error "declare-weight should have at least one argument.")
    | "inv-constraint" ->
      (match sl with
      | [ Atom s1; Atom s2; Atom s3; Atom s4 ] -> Ok (CInvConstraint (s1, s2, s3, s4))
      | _ -> Error "inv-constraint takes exactly 4 symbols as arguments.")
    | "optimize-synth" ->
      (match sl with
      | List terms :: attributes ->
        Result.(
          attributes_of_sexps attributes
          >>| fun attrs -> COptimizeSynth (List.map ~f:sygus_term_of_sexp terms, attrs))
      | _ ->
        Error
          "optimize-synth takes a list of terms and a list of attributes as arguments.")
    | "set-feature" ->
      (match sl with
      | [ Atom feature; Atom setting ] ->
        Result.(
          feature_of_sexp (Atom feature)
          >>| fun fture -> CSetFeature (fture, bool_of_sexp (Atom setting)))
      | _ -> Error "set-feature takes a feature and a boolean as arguments.")
    | "synth-fun" ->
      (match sl with
      | [ name; List args; ret_sort; gd1; gd2 ] ->
        Ok
          (CSynthFun
             ( symbol_of_sexp name
             , List.map ~f:sorted_var_of_sexp args
             , sygus_sort_of_sexp ret_sort
             , Some (grammar_def_of_sexps (Some gd1) gd2) ))
      | [ name; List args; ret_sort ] ->
        Ok
          (CSynthFun
             ( symbol_of_sexp name
             , List.map ~f:sorted_var_of_sexp args
             , sygus_sort_of_sexp ret_sort
             , None ))
      | [ name; List args; ret_sort; gd2 ] ->
        let v1 =
          CSynthFun
            ( symbol_of_sexp name
            , List.map ~f:sorted_var_of_sexp args
            , sygus_sort_of_sexp ret_sort
            , Some (grammar_def_of_sexps None gd2) )
        in
        raise_nonconforming
          v1
          "This synth-fun should have non-terminal declarations before the grammar."
      | _ ->
        Error
          "synth-fun takes as arguments a function name, variables with sorts a return \
           sort and an optional grammar")
    | "synth-inv" ->
      (match sl with
      | [ name; List args; gd1; gd2 ] ->
        Ok
          (CSynthFun
             ( symbol_of_sexp name
             , List.map ~f:sorted_var_of_sexp args
             , sygus_sort_of_sexp (Atom "Bool")
             , Some (grammar_def_of_sexps (Some gd1) gd2) ))
      | [ name; List args ] ->
        Ok
          (CSynthFun
             ( symbol_of_sexp name
             , List.map ~f:sorted_var_of_sexp args
             , sygus_sort_of_sexp (Atom "Bool")
             , None ))
      | [ name; List args; gd2 ] ->
        let v1 =
          CSynthFun
            ( symbol_of_sexp name
            , List.map ~f:sorted_var_of_sexp args
            , sygus_sort_of_sexp (Atom "Bool")
            , Some (grammar_def_of_sexps None gd2) )
        in
        raise_nonconforming
          v1
          "This synth-fun should have non-terminal declarations before the grammar."
      | _ ->
        Error
          "synth-fun takes as arguments a function name, variables with sorts a return \
           sort and an optional grammar")
    | "declare-datatype" ->
      (match sl with
      | [ a; b ] -> Ok (CDeclareDataType (symbol_of_sexp a, dt_cons_dec_list_of_sexp b))
      | _ ->
        Error "declare-datatypes takes a symbol and a list of constructors as arguments")
    | "declare-datatypes" ->
      (match sl with
      | [ a; List b ] ->
        Ok
          (CDeclareDataTypes
             (sygus_sort_decl_list_of_sexp a, List.map ~f:dt_cons_dec_list_of_sexp b))
      | _ ->
        Error "declare-datatypes takes a symbol and a list of constructors as arguments")
    | "declare-sort" ->
      (match sl with
      | [ s; n ] -> Ok (CDeclareSort (symbol_of_sexp s, Int.t_of_sexp n))
      | _ -> Error "A sort declaration with declare-sort takes a name and an index.")
    | "define-fun" ->
      (match sl with
      | [ name; List args; ret_sort; body ] ->
        Ok
          (CDefineFun
             ( symbol_of_sexp name
             , List.map ~f:sorted_var_of_sexp args
             , sygus_sort_of_sexp ret_sort
             , sygus_term_of_sexp body ))
      | _ -> Error "")
    | "define-sort" ->
      (match sl with
      | [ name; sort ] -> Ok (CDefineSort (symbol_of_sexp name, sygus_sort_of_sexp sort))
      | _ -> Error "define-sort takes a name and a sort as arguments.")
    | "set-info" ->
      (match sl with
      | [ kw; lit ] ->
        Result.of_option
          ~error:"Bad keyword"
          Option.(keyword_of_sexp kw >>| fun keyw -> CSetInfo (keyw, literal_of_sexp lit))
      | _ -> Error "set-info takes a keyword and a literal as arguments.")
    | "set-logic" ->
      (match sl with
      | [ lname ] -> Ok (CSetLogic (symbol_of_sexp lname))
      | _ -> Error "set-logic only takes a logic name as argument.")
    | "set-option" ->
      (match sl with
      | [ kw; lit ] ->
        Result.of_option
          ~error:"Bad keyword"
          Option.(
            keyword_of_sexp kw >>| fun keyw -> CSetOption (keyw, literal_of_sexp lit))
      | _ -> Error "set-option takes a keyword and a literal as arguments.")
    | "oracle-assume" ->
      (match sl with
      | [ List q1; List q2; body; oname ] ->
        Ok
          (COracle
             (OAssume
                ( List.map ~f:sorted_var_of_sexp q1
                , List.map ~f:sorted_var_of_sexp q2
                , sygus_term_of_sexp body
                , symbol_of_sexp oname )))
      | _ ->
        Error "Oracle command oracle-assume doesn't have the right number of arguments.")
    | "oracle-constraint" ->
      (match sl with
      | [ List q1; List q2; body; oname ] ->
        Ok
          (COracle
             (OConstraint
                ( List.map ~f:sorted_var_of_sexp q1
                , List.map ~f:sorted_var_of_sexp q2
                , sygus_term_of_sexp body
                , symbol_of_sexp oname )))
      | _ ->
        Error
          "Oracle command oracle-constraint doesn't have the right number of arguments.")
    | "declare-oracle-fun" ->
      (match sl with
      | [ name; List args; ret_sort; oname ] ->
        Ok
          (COracle
             (ODeclareFun
                ( symbol_of_sexp name
                , List.map ~f:sygus_sort_of_sexp args
                , sygus_sort_of_sexp ret_sort
                , symbol_of_sexp oname )))
      | _ ->
        Error
          "Oracle command declare-oracle-fun doesn't have the right number of arguments.")
    | "oracle-constraint-io" ->
      (match sl with
      | [ s1; s2 ] -> Ok (COracle (OConstraintIO (symbol_of_sexp s1, symbol_of_sexp s2)))
      | _ ->
        Error "Oracle command oracle-constraint-io accepts exactly two symbol arguments.")
    | "oracle-constraint-cex" ->
      (match sl with
      | [ s1; s2 ] -> Ok (COracle (OConstraintCex (symbol_of_sexp s1, symbol_of_sexp s2)))
      | _ ->
        Error "Oracle command oracle-constraint-cex accepts exactly two symbol arguments.")
    | "oracle-constraint-membership" ->
      (match sl with
      | [ s1; s2 ] -> Ok (COracle (OConstraintMem (symbol_of_sexp s1, symbol_of_sexp s2)))
      | _ ->
        Error
          "Oracle command oracle-constraint-membership accepts exactly two symbol \
           arguments.")
    | "oracle-constraint-poswitness" ->
      (match sl with
      | [ s1; s2 ] ->
        Ok (COracle (OConstraintPosw (symbol_of_sexp s1, symbol_of_sexp s2)))
      | _ ->
        Error
          "Oracle command oracle-constraint-poswitness accepts exactly two symbol \
           arguments.")
    | "oracle-constraint-negwitness" ->
      (match sl with
      | [ s1; s2 ] ->
        Ok (COracle (OConstraintNegw (symbol_of_sexp s1, symbol_of_sexp s2)))
      | _ ->
        Error
          "Oracle command oracle-constraint-negwitness accepts exactly two symbol \
           arguments.")
    | "declare-correctness-oracle" ->
      (match sl with
      | [ s1; s2 ] -> Ok (COracle (OCorrectness (symbol_of_sexp s1, symbol_of_sexp s2)))
      | _ ->
        Error
          "Oracle command oracle-correctness-oracle accepts exactly two symbol arguments.")
    | "declare-correctness-cex-oracle" ->
      (match sl with
      | [ s1; s2 ] ->
        Ok (COracle (OCorrectnessCex (symbol_of_sexp s1, symbol_of_sexp s2)))
      | _ ->
        Error
          "Oracle command oracle-correctness-cex-oracle accepts exactly two symbol \
           arguments.")
    | _ -> Error Fmt.(str "I do not know this command: %a" Sexp.pp_hum s)
  in
  match s with
  | List (Atom command_name :: elts) ->
    (match command_of_elts command_name elts with
    | Ok c -> c
    | Error msg -> raise_parse_error s (msg ^ "(while parsing a command)"))
  | _ -> raise_parse_error s "A command should start with a name."
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

let sexp_parse (filename : string) =
  program_of_sexp_list (Sexp.input_sexps (Stdio.In_channel.create filename))
;;
