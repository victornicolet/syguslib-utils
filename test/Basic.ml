open Core
open Sexplib
open Syguslib

let bench_home = "../../../test/inputs"

let parse_test filename =
  let filename = Filename.concat bench_home filename in
  Fmt.(pf stdout "TEST: %s@." filename);
  let sexps = Sexp.input_sexps (Stdio.In_channel.create filename) in
  let parsed = Parser.program_of_sexp_list sexps in
  if Semantic.is_well_formed parsed
  then ()
  else failwith (Fmt.str "%s is not well formed" filename)
;;

let benchfiles = Array.filter ~f:Sygus.has_standard_extension (Sys.readdir bench_home)
(* dune test runs in _build/default/test.  *)
;;

Array.iter ~f:parse_test benchfiles
