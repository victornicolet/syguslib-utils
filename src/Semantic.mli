module Command : sig
  type t = Sygus.command

  val of_sexp : Sexplib0.Sexp.t -> t
  val sexp_of : t -> Sexplib0.Sexp.t
  val pp : Format.formatter -> t -> unit
  val pp_hum : Format.formatter -> t -> unit
end

module Term : sig
  type t = Sygus.sygus_term

  val of_sexp : Sexplib0.Sexp.t -> t
  val sexp_of : t -> Sexplib0.Sexp.t
  val pp : Format.formatter -> t -> unit
  val pp_hum : Format.formatter -> t -> unit
end

module Ident : sig
  type t = Sygus.identifier

  val of_sexp : Sexplib0.Sexp.t -> t
  val sexp_of : t -> Sexplib0.Sexp.t
  val pp : Format.formatter -> t -> unit
  val pp_hum : Format.formatter -> t -> unit
end

module Lit : sig
  type t = Sygus.literal

  val of_sexp : Sexplib0.Sexp.t -> t
  val sexp_of : t -> Sexplib0.Sexp.t
  val pp : Format.formatter -> t -> unit
  val pp_hum : Format.formatter -> t -> unit
end

module Sort : sig
  type t = Sygus.sygus_sort

  val of_sexp : Sexplib0.Sexp.t -> t
  val sexp_of : t -> Sexplib0.Sexp.t
  val pp : Format.formatter -> t -> unit
  val pp_hum : Format.formatter -> t -> unit
end

val is_setter_command : Sygus.command -> bool
val is_well_formed : Sygus.program -> bool
val declares : Sygus.command -> string list
val compare_declares : Sygus.command -> Sygus.command -> int
val max_definition : Sygus.command
val min_definition : Sygus.command
val rename : (string * string) list -> Sygus.sygus_term -> Sygus.sygus_term
val write_command : out_channel -> Sygus.command -> unit
