(* coq-elpi: Coq terms as the object language of elpi                        *)
(* license: GNU Lesser General Public License Version 2.1 or later           *)
(* ------------------------------------------------------------------------- *)

open Elpi.API

val coq_builtins : BuiltIn.declaration list

(* Clauses to be added to elpi programs when the execution is over *)

val clauses_for_later :
  (string list * Ast.program) list State.component
val set_accumulate_to_db : ((unit -> Setup.elpi) * (string list -> Compile.compilation_unit -> unit)) -> unit

(* In tactic mode some APIs are disabled *)
val tactic_mode : bool ref