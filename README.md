# syguslib-utils

This project is an s-expression based parser as well as serializer for the [SyGuS Language Standard v2.1](https://sygus.org/language/). It also contains utilities to call solvers from OCaml programs.

`syguslib-utils` is written in OCaml and relies on the  [opam](https://opam.ocaml.org/) package manager. To install all the dependencies, type `opam install . --deps-only` from the root.

To build the project:

```dune build```

and to run the tests:

```dune runtest```
