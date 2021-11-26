(** This module defines function to convert from s-expressions
  to sygus.
*)

val symbol_of_sexp : Sexplib0.Sexp.t -> string
val feature_of_sexp : Sexplib0.Sexp.t -> (Sygus.feature, string) Result.t
val index_of_sexp : Sexplib0.Sexp.t -> Sygus.index
val identifier_of_sexp : Sexplib0.Sexp.t -> Sygus.identifier
val sygus_sort_of_sexp : Sexplib0.Sexp.t -> Sygus.sygus_sort
val sorted_var_of_sexp : Sexplib0.Sexp.t -> Sygus.sorted_var
val literal_of_string : string -> Sygus.literal
val literal_of_sexp : Sexplib0.Sexp.t -> Sygus.literal
val sygus_term_of_sexp : Sexplib0.Sexp.t -> Sygus.sygus_term
val binding_of_sexp : Sexplib0.Sexp.t -> Sygus.binding
val sygus_sort_decl_of_sexp : Sexplib0.Sexp.t -> Sygus.sygus_sort_decl
val dt_cons_dec_list_of_sexp : Sexplib0.Sexp.t -> Sygus.dt_cons_dec list
val sygus_sort_decl_list_of_sexp : Sexplib0.Sexp.t -> Sygus.sygus_sort_decl list
val dt_cons_dec_of_sexp : Sexplib0.Sexp.t -> Sygus.dt_cons_dec
val sygus_gsterm_of_sexp : Sexplib0.Sexp.t -> Sygus.sygus_gsterm

val pre_grouped_rule_of_sexp
  :  Sexplib0.Sexp.t
  -> string * Sygus.sygus_sort * Sygus.sygus_gsterm list

val grammar_def_of_sexps : Sexplib0.Sexp.t -> Sexplib0.Sexp.t -> Sygus.grammar_def
val command_of_sexp : Sexplib0.Sexp.t -> Sygus.command
val program_of_sexp_list : Sexplib0.Sexp.t list -> Sygus.program

(**
    Translate a s-expression return by a solver to a [solver_response]
*)
val reponse_of_sexps : Sexplib0.Sexp.t list -> Sygus.solver_response
