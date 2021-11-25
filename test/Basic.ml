open Core
open Sexplib

let bench_home = "../../../test/inputs"

let parse_test filename =
  let filename = Filename.concat bench_home filename in
  Fmt.(pf stdout "PARSE: %s@." filename);
  let sexps = Sexp.input_sexps (Stdio.In_channel.create filename) in
  let parsed = Syguslib.Parser.program_of_sexp_list sexps in
  let _ = Syguslib.Serializer.sexp_list_of_program parsed in
  ()
;;

let benchfiles =
  Array.filter ~f:Syguslib.Sygus.has_standard_extension (Sys.readdir bench_home)
(* dune test runs in _build/default/test.  *)
;;

Array.iter ~f:parse_test benchfiles
