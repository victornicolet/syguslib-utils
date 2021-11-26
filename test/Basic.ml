open Core
open Sexplib
open Syguslib

let bench_positive_home = "../../../test/inputs/positive"
let bench_negative_home = "../../../test/inputs/negative"

let pos_parse_test filename =
  let filename = Filename.concat bench_positive_home filename in
  Fmt.(pf stdout "TEST: %s@." filename);
  let sexps = Sexp.input_sexps (Stdio.In_channel.create filename) in
  try
    let parsed = Parser.program_of_sexp_list sexps in
    if Semantic.is_well_formed parsed
    then ()
    else failwith (Fmt.str "%s is not well formed" filename)
  with
  | Parser.NonConforming _ -> failwith (Fmt.str "%s is nonconforming!" filename)
;;

let neg_parse_test filename =
  let filename = Filename.concat bench_negative_home filename in
  Fmt.(pf stdout "TEST: %s@." filename);
  let sexps = Sexp.input_sexps (Stdio.In_channel.create filename) in
  try
    let parsed = Parser.program_of_sexp_list sexps in
    if Semantic.is_well_formed parsed
    then failwith (Fmt.str "%s parsed succesfully, it should not be." filename)
    else ()
  with
  | Parser.NonConforming _ | Parser.ParseError _ -> ()
  | _ -> failwith "Failed to parse, but exception was not as expected."
;;

let benchfiles_pos =
  Array.filter ~f:Sygus.has_standard_extension (Sys.readdir bench_positive_home)
;;

let benchfiles_neg =
  Array.filter ~f:Sygus.has_standard_extension (Sys.readdir bench_negative_home)
(* dune test runs in _build/default/test.  *)
;;

Array.iter ~f:pos_parse_test benchfiles_pos;
Array.iter ~f:neg_parse_test benchfiles_neg
