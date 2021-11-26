open Base
open Sygus
open Parser
open Serializer
open Sexplib

(* ============================================================================================= *)
(*                                      WRAPPER MODULES                                          *)
(* ============================================================================================= *)

module Command = struct
  type t = command

  let of_sexp = command_of_sexp
  let sexp_of = sexp_of_command
  let pp fmt c = Sexp.pp fmt (sexp_of c)
  let pp_hum fmt c = Sexp.pp_hum fmt (sexp_of c)
end

module Term = struct
  type t = sygus_term

  let of_sexp = sygus_term_of_sexp
  let sexp_of = sexp_of_sygus_term
  let pp fmt c = Sexp.pp fmt (sexp_of c)
  let pp_hum fmt c = Sexp.pp_hum fmt (sexp_of c)
end

module Ident = struct
  type t = identifier

  let of_sexp = identifier_of_sexp
  let sexp_of = sexp_of_identifier
  let pp fmt c = Sexp.pp fmt (sexp_of c)
  let pp_hum fmt c = Sexp.pp_hum fmt (sexp_of c)
end

module Lit = struct
  type t = literal

  let of_sexp = literal_of_sexp
  let sexp_of = sexp_of_literal
  let pp fmt c = Sexp.pp fmt (sexp_of c)
  let pp_hum fmt c = Sexp.pp_hum fmt (sexp_of c)
end

module Sort = struct
  type t = sygus_sort

  let of_sexp = sygus_sort_of_sexp
  let sexp_of = sexp_of_sygus_sort
  let pp fmt c = Sexp.pp fmt (sexp_of c)
  let pp_hum fmt c = Sexp.pp_hum fmt (sexp_of c)
end

(* ============================================================================================= *)
(*                       SEMANTIC PROPERTIES                                                     *)
(* ============================================================================================= *)

let is_setter_command (c : Command.t) =
  match c with
  | CSetFeature _ | CSetInfo _ | CSetLogic _ | CSetOption _ -> true
  | _ -> false
;;

let is_well_formed (p : program) : bool =
  let setter_then_other l =
    let _, b =
      List.fold l ~init:(false, true) ~f:(fun (b0, b1) c ->
          let b = is_setter_command c in
          b0 && b, b1 && ((not b) || (b && b0)))
    in
    b
  in
  match p with
  | [] -> true
  | hd :: tl ->
    (match hd with
    | CSetLogic _ -> setter_then_other tl
    | _ -> setter_then_other p)
;;

let declares (c : command) : symbol list =
  match c with
  | CCheckSynth
  | CInvConstraint _
  | CSetFeature _
  | CSetInfo _
  | CSetOption _
  | CSetLogic _
  | CAssume _
  | COptimizeSynth _
  | CChcConstraint _
  | CConstraint _ -> []
  | CDeclareVar (s, _)
  | CSynthFun (s, _, _, _)
  | CSynthInv (s, _, _)
  | CDeclareSort (s, _)
  | CDefineFun (s, _, _, _)
  | CDefineSort (s, _) -> [ s ]
  | CDeclareWeight (s, _) -> [ s ]
  | CDeclareDataType (s, constrs) -> s :: List.map ~f:fst constrs
  | CDeclareDataTypes (sl, cd) ->
    List.map ~f:fst sl @ List.concat_map ~f:(List.map ~f:fst) cd
;;

let compare_declares (c1 : command) (c2 : command) =
  List.compare String.compare (declares c1) (declares c2)
;;

(* ============================================================================================= *)
(*                       STATIC DEFINITIONS                                                      *)
(* ============================================================================================= *)

let max_definition =
  Command.of_sexp
    (Sexp.of_string "(define-fun max ((x Int) (y Int)) Int (ite (>= x y) x y))")
;;

let min_definition =
  Command.of_sexp
    (Sexp.of_string "(define-fun min ((x Int) (y Int)) Int (ite (<= x y) x y))")
;;

(* ============================================================================================= *)
(*                       TRANSFORMERS                                                            *)
(* ============================================================================================= *)
let rec rename (subs : (symbol * symbol) list) (t : sygus_term) : sygus_term =
  match t with
  | SyId (IdSimple s) ->
    (match List.Assoc.find ~equal:String.equal subs s with
    | Some s' -> SyId (IdSimple s')
    | None -> t)
  | SyApp (IdSimple f, args) ->
    let args' = List.map ~f:(rename subs) args in
    (match List.Assoc.find ~equal:String.equal subs f with
    | Some f' -> SyApp (IdSimple f', args')
    | None -> SyApp (IdSimple f, args'))
  | SyApp (f, args) -> SyApp (f, List.map ~f:(rename subs) args)
  | SyExists (vars, body) ->
    let subs' =
      List.filter ~f:(fun (l, _) -> List.Assoc.mem ~equal:String.equal vars l) subs
    in
    SyExists (vars, rename subs' body)
  | SyForall (vars, body) ->
    let subs' =
      List.filter ~f:(fun (l, _) -> List.Assoc.mem ~equal:String.equal vars l) subs
    in
    SyForall (vars, rename subs' body)
  | SyLit _ | SyId _ -> t
  | SyLet (bindings, body) ->
    let bindings' =
      List.map ~f:(fun (varname, body) -> varname, rename subs body) bindings
    in
    let subs' =
      List.filter ~f:(fun (l, _) -> List.Assoc.mem ~equal:String.equal bindings l) subs
    in
    let body' = rename subs' body in
    SyLet (bindings', body')
;;

let write_command (out : Stdio.Out_channel.t) (c : command) : unit =
  let comm_s = Fmt.(to_to_string Command.pp c) in
  Stdio.Out_channel.(
    output_lines out [ comm_s ];
    flush out)
;;
