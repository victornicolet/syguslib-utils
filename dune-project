(lang dune 2.9)

(name syguslib-utils)

(version 0.2.1)

(license MIT)

(authors "Victor Nicolet")

(maintainers "victor.nicolet@pm.me")

(homepage "https://github.com/victornicolet/syguslib-utils")

(bug_reports "https://github.com/victornicolet/sygusllib-utils/issues")

(source
 (github victornicolet/syguslib-utils))

(generate_opam_files true)

(package
 (name syguslib-utils)
 (synopsis "SyGuS Lib parser and utils")
 (description
  "SyGuS Language Standard v2.1 parser with utils for using SyGuS solvers.")
 (depends
  (base
   (>= v0.14.0))
  (fmt
   (>= 0.8))
  (getopt
   (>= 20120615))
  (lwt
   (>= 5.4.0))
  (lwt_ppx
   (>= 2.0))
  (odoc
   (>= 1.5))
  (parsexp
   (>= v0.14.0))
  (parsexp_io
   (>= v0.14.0))
  ; for tests
  (core
   (>= v0.14.0))
  (core_unix
   (and
    (>= 0.14.0)))
  (stdio
   (>= v0.14.0))))
