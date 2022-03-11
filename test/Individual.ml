open Base
open Syguslib

let files =
  [ "../../../test/inputs/errors/ex1.sl"
  ; "../../../test/inputs/errors/ex2.sl"
  ; "../../../test/inputs/errors/unknown_command.sl"
  ; "../../../test/inputs/errors/bad_term.sl"
  ; "../../../test/inputs/errors/bad_constraint.sl"
  ]
;;

let test () =
  let f filename =
    try
      let parsed = Parser.sexp_parse filename in
      if Semantic.is_well_formed parsed
      then failwith (Fmt.str "Expected an error on %s" filename)
      else ()
    with
    | Parser.NonConforming _ ->
      failwith (Fmt.str "%s is nonconforming, expected parse error" filename)
    | Parser.ParseError (_, what, msg) ->
      Fmt.(
        pf
          stdout
          "OK:@[@;Got expected error@]@;@[%s@]@;@[Could not parse@;@[%a@]@]@."
          msg
          Sexp.pp_hum
          what)
  in
  List.iter files ~f
;;

test ()
