(**
   This implementation is based on the SyGuS Language Standard Version 2.0.
   Documentation can be found at https://sygus.org/language/
*)
open Base

let use_v1 = ref false

(* ============================================================================================= *)
(*                               TYPES FOR SYGUS SYNTAX                                          *)
(* ============================================================================================= *)

type symbol = string

type literal =
  | LitNum of int
  | LitDec of float
  | LitBool of bool
  | LitHex of string
  | LitBin of bool list
  | LitString of string

type index =
  | INum of int
  | ISym of symbol

type identifier =
  | IdSimple of symbol
  | IdIndexed of symbol * index list
  | IdQual of symbol * sygus_sort

and sygus_sort =
  | SId of identifier
  | SApp of identifier * sygus_sort list

type sygus_term =
  | SyId of identifier
  | SyLit of literal
  | SyApp of identifier * sygus_term list
  | SyExists of sorted_var list * sygus_term
  | SyForall of sorted_var list * sygus_term
  | SyLet of binding list * sygus_term

and sorted_var = symbol * sygus_sort

and binding = symbol * sygus_term

type feature =
  | FGrammar
  | FFwdDecls
  | FRecursion

type command =
  | CCheckSynth
  | CConstraint of sygus_term
  | CDeclareVar of symbol * sygus_sort
  | CInvConstraint of symbol * symbol * symbol * symbol
  | CSetFeature of feature * bool
  | CSynthFun of symbol * sorted_var list * sygus_sort * grammar_def option
  | CSynthInv of symbol * sorted_var list * grammar_def option
  | CDeclareDataType of symbol * dt_cons_dec list
  | CDeclareDataTypes of sygus_sort_decl list * dt_cons_dec list list
  | CDeclareSort of symbol * int
  | CDefineFun of symbol * sorted_var list * sygus_sort * sygus_term
  | CDefineSort of symbol * sygus_sort
  | CSetInfo of symbol * literal
  | CSetLogic of symbol
  | CSetOption of symbol * literal

and sygus_sort_decl = symbol * int

and dt_cons_dec = symbol * sorted_var list

and grammar_def = (sorted_var * grouped_rule_list) list

and grouped_rule_list = sygus_gsterm list

and sygus_gsterm =
  | GConstant of sygus_sort
  | GTerm of sygus_term
  | GVar of sygus_sort

type program = command list

let special_chars : char list =
  [ '_'; '+'; '-'; '*'; '&'; '|'; '!'; '~'; '<'; '>'; '='; '/'; '%'; '?'; '.'; '$'; '^' ]
;;

let reserved_words : string list =
  [ "check-synth"
  ; "Constant"
  ; "constraint"
  ; "declare-datatype"
  ; "declare-datatypes"
  ; "declare-sort"
  ; "declare-var"
  ; "define-fun"
  ; "define-sort"
  ; "exists"
  ; "forall"
  ; "inv-constraint"
  ; "let"
  ; "set-feature"
  ; "set-info"
  ; "set-logic"
  ; "set-option"
  ; "synth-fun"
  ; "synth-inv"
  ; "Variable"
  ]
;;

let digits = [ '0'; '1'; '2'; '3'; '4'; '5'; '6'; '7'; '8'; '9' ]

(**
   `valid_ident name` is `true` whenever `name` is not a reserved word, and does not contain
   any special character.
*)
let valid_ident (name : string) =
  (not (List.mem ~equal:String.equal reserved_words name))
  &&
  match String.to_list name with
  | hd :: _ -> not (List.mem ~equal:Char.equal digits hd)
  | [] -> false
;;

let char_to_bool (c : char) = if Char.(c = '0') then false else true

(* ============================================================================================= *)
(*                                      SOLVER RESPONSES                                         *)
(* ============================================================================================= *)

type solver_response =
  | RSuccess of (symbol * sorted_var list * sygus_sort * sygus_term) list
  | RInfeasible
  | RFail
  | RUnknown

let is_sat = function
  | RSuccess _ -> true
  | _ -> false
;;

let is_failed = function
  | RFail -> true
  | _ -> false
;;

let is_infeasible = function
  | RInfeasible -> true
  | _ -> false
;;
