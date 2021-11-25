open Base
open Sygus
open Sexplib

let sexp_of_symbol (s : symbol) : Sexp.t = Atom s

let sexp_of_index (i : index) : Sexp.t =
  match i with
  | INum i -> Atom (Int.to_string i)
  | ISym s -> Atom s
;;

let rec sexp_of_identifier (id : identifier) : Sexp.t =
  match id with
  | IdSimple name -> Atom name
  | IdIndexed (name, indices) ->
    List (Atom "_" :: sexp_of_symbol name :: List.map ~f:sexp_of_index indices)
  | IdQual (name, sort) ->
    List [ Atom "as"; sexp_of_symbol name; sexp_of_sygus_sort sort ]

and sexp_of_sygus_sort (s : sygus_sort) : Sexp.t =
  match s with
  | SId s -> sexp_of_identifier s
  | SApp (sname, sygus_sort_params) ->
    List (sexp_of_identifier sname :: List.map ~f:sexp_of_sygus_sort sygus_sort_params)
;;

let bool_list_to_bin_string (l : bool list) =
  String.concat (List.map ~f:(fun b -> if b then "1" else "0") l)
;;

let sexp_of_literal (l : literal) : Sexp.t =
  match l with
  | LitNum i -> Atom (Int.to_string i)
  | LitDec f -> Atom (Float.to_string f)
  | LitBool b -> Atom (Bool.to_string b)
  | LitHex s -> Atom ("#x" ^ s)
  | LitBin b -> Atom ("#b" ^ bool_list_to_bin_string b)
  | LitString s -> Atom ("\"" ^ s ^ "\"")
;;

let sexp_of_sorted_var ((symb, sygus_sort) : sorted_var) : Sexp.t =
  List [ sexp_of_symbol symb; sexp_of_sygus_sort sygus_sort ]
;;

let rec sexp_of_sygus_term (t : sygus_term) : Sexp.t =
  match t with
  | SyId s -> sexp_of_identifier s
  | SyLit l -> sexp_of_literal l
  | SyApp (f, args) -> List (sexp_of_identifier f :: List.map ~f:sexp_of_sygus_term args)
  | SyExists (vars, body) ->
    List
      [ Atom "exists"
      ; List (List.map ~f:sexp_of_sorted_var vars)
      ; sexp_of_sygus_term body
      ]
  | SyForall (vars, body) ->
    List
      [ Atom "forall"
      ; List (List.map ~f:sexp_of_sorted_var vars)
      ; sexp_of_sygus_term body
      ]
  | SyLet (bindings, body) ->
    List
      [ Atom "let"
      ; List
          (List.map bindings ~f:(fun (s, t) ->
               Sexp.List [ sexp_of_symbol s; sexp_of_sygus_term t ]))
      ; sexp_of_sygus_term body
      ]
;;

let sexp_of_feature (f : feature) : Sexp.t =
  match f with
  | FGrammar -> Atom "grammars"
  | FFwdDecls -> Atom "fwd-decls"
  | FRecursion -> Atom "recursion"
;;

let sexp_of_sort_decl ((name, id) : sygus_sort_decl) : Sexp.t =
  List [ Atom name; Atom (Int.to_string id) ]
;;

let sexp_of_dt_cons_dec ((s, args_sorts) : dt_cons_dec) : Sexp.t =
  List (Atom s :: List.map ~f:sexp_of_sorted_var args_sorts)
;;

let sexp_of_sygus_gsterm (t : sygus_gsterm) : Sexp.t =
  match t with
  | GConstant c -> List [ Atom "Constant"; sexp_of_sygus_sort c ]
  | GTerm t -> sexp_of_sygus_term t
  | GVar v -> List [ Atom "Variable"; sexp_of_sygus_sort v ]
;;

let sexp_of_grammar_def (gr : grammar_def) : Sexp.t * Sexp.t =
  let headers = List.map ~f:(fun (s, _) -> sexp_of_sorted_var s) gr in
  let grammar_decls =
    List.map gr ~f:(fun ((x, y), z) ->
        Sexp.List
          [ sexp_of_symbol x
          ; sexp_of_sygus_sort y
          ; Sexp.List (List.map ~f:sexp_of_sygus_gsterm z)
          ])
  in
  List headers, List grammar_decls
;;

let sexp_of_command (c : command) : Sexp.t =
  match c with
  | CCheckSynth -> List [ Atom "check-synth" ]
  | CConstraint t -> List [ Atom "constraint"; sexp_of_sygus_term t ]
  | CDeclareVar (name, sygus_sort) ->
    List [ Atom "declare-var"; sexp_of_symbol name; sexp_of_sygus_sort sygus_sort ]
  | CInvConstraint (a, b, c, d) ->
    List [ Atom "inv-constraint"; Atom a; Atom b; Atom c; Atom d ]
  | CSetFeature (feat, boolc) ->
    List
      [ Atom "set-feature"; Atom ":"; sexp_of_feature feat; Atom (Bool.to_string boolc) ]
  | CSynthFun (name, args, res, body) ->
    (match body with
    | Some body ->
      let decls, gramm = sexp_of_grammar_def body in
      if !use_v1
      then
        (* No predeclaration in v1 *)
        List
          [ Atom "synth-fun"
          ; Atom name
          ; List (List.map ~f:sexp_of_sorted_var args)
          ; sexp_of_sygus_sort res
          ; gramm
          ]
      else
        List
          [ Atom "synth-fun"
          ; Atom name
          ; List (List.map ~f:sexp_of_sorted_var args)
          ; sexp_of_sygus_sort res
          ; decls
          ; gramm
          ]
    | None ->
      List
        [ Atom "synth-fun"
        ; Atom name
        ; List (List.map ~f:sexp_of_sorted_var args)
        ; sexp_of_sygus_sort res
        ])
  | CSynthInv (name, args, body) ->
    (match body with
    | Some body ->
      let decls, gramm = sexp_of_grammar_def body in
      List
        [ Atom "synth-fun"
        ; Atom name
        ; List (List.map ~f:sexp_of_sorted_var args)
        ; sexp_of_sygus_sort (SId (IdSimple "Bool"))
        ; decls
        ; gramm
        ]
    | None ->
      if !use_v1
      then
        List [ Atom "synth-inv"; Atom name; List (List.map ~f:sexp_of_sorted_var args) ]
      else
        List
          [ Atom "synth-fun"
          ; Atom name
          ; List (List.map ~f:sexp_of_sorted_var args)
          ; sexp_of_sygus_sort (SId (IdSimple "Bool"))
          ])
  | CDeclareDataType (name, dtdecls) ->
    List
      [ Atom "declare-datatype"
      ; Atom name
      ; List (List.map ~f:sexp_of_dt_cons_dec dtdecls)
      ]
  | CDeclareDataTypes (sortdec, dtdecls) ->
    List
      [ Atom "declare-datatypes"
      ; List (List.map ~f:sexp_of_sort_decl sortdec)
      ; List
          (List.map ~f:(fun x -> Sexp.List (List.map ~f:sexp_of_dt_cons_dec x)) dtdecls)
      ]
  | CDeclareSort (name, id) ->
    List [ Atom "declare-sort"; Atom name; Atom (Int.to_string id) ]
  | CDefineFun (name, args, res, body) ->
    List
      [ Atom "define-fun"
      ; Atom name
      ; List (List.map ~f:sexp_of_sorted_var args)
      ; sexp_of_sygus_sort res
      ; sexp_of_sygus_term body
      ]
  | CDefineSort (name, sygus_sort) ->
    List [ Atom "define-sort"; Atom name; sexp_of_sygus_sort sygus_sort ]
  | CSetInfo (sym, lit) ->
    List [ Atom "set-info"; Atom ":"; Atom sym; sexp_of_literal lit ]
  | CSetLogic sym -> List [ Atom "set-logic"; Atom sym ]
  | CSetOption (sym, lit) ->
    List [ Atom "set-option"; Atom ":"; Atom sym; sexp_of_literal lit ]
;;

let sexp_list_of_program (p : program) : Sexp.t list = List.map ~f:sexp_of_command p
