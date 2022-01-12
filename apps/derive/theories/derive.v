(* Generates a module containing all the derived constants.

   license: GNU Lesser General Public License Version 2.1 or later
   ------------------------------------------------------------------------- *)

(** The derive command
   The derive command can be invoked in two ways.
   - [derive <inductive-type> <prefix>]
   - [derive Inductive <declaration>]
     [derive Record <declaration>]

   The first command runs all the derivations on an alerady declared inductive
   type named [<inductive-type>] and all generated constants are named after the
   prefix [<prefix>] (by default the inductive type name followed by [_]). Example:

<<
      derive nat. (* default prefix nat_ *)
      derive nat my_nat_stuff_.
>>

   The second command takes as argument an inductive type declaration, it
   creates a module named after the inductive type and puts inside id both
   the inductive types and the output of the derivations. Example:

<<
     derive Inductive tickle A := stop | more : A -> tickle-> tickle.
>>

   is equivalent to

<<
     Module tickle.
     Inductive tickle A := stop | more : A -> tickle-> tickle.
     derive tickle "".
     End tickle.
     Notation tickle := tickle.tickle.
     Notation stop := tickle.stop.
     Notation more := tickle.more.
>>

  Both commands honor the [#[verbose]] attribute. If set they print all
  the derivations that are run, and if they fail or succeed.

  A derivation d can be skipped by using the [#[skip(d)]] attribute.
  A derivation different from d can be skipped [#[only(d)]] attribute.

*)

From elpi.apps Require Export
  derive.eq
  derive.isK
  derive.map
  derive.projK
  derive.param1
  derive.param1_congr
  derive.param1_inhab
  derive.param1_trivial
  derive.invert
  derive.idx2inv
  derive.induction
  derive.bcongr
  derive.eqK
  derive.eqcorrect
  derive.eqOK
  derive.param2
  derive.lens
  derive.lens_laws
  derive.eqb_core_defs
  derive.tag
  derive.fields
  derive.eqb
  derive.eqbcorrect
.

Elpi Command derive.

Elpi Accumulate Db derive.eq.db.
Elpi Accumulate File "elpi/eq.elpi".

Elpi Accumulate Db derive.isK.db.
Elpi Accumulate File "elpi/isK.elpi".

Elpi Accumulate Db derive.map.db.
Elpi Accumulate File "elpi/map.elpi".

Elpi Accumulate Db derive.projK.db.
Elpi Accumulate File "elpi/projK.elpi".

Elpi Accumulate File "paramX-lib.elpi".

Elpi Accumulate File "elpi/param1.elpi".
Elpi Accumulate Db derive.param1.db.

Elpi Accumulate Db derive.param1.functor.db.
Elpi Accumulate File "elpi/param1_functor.elpi".

Elpi Accumulate Db derive.param1.congr.db.
Elpi Accumulate File "elpi/param1_congr.elpi".

Elpi Accumulate Db derive.param1.inhab.db.
Elpi Accumulate File "elpi/param1_inhab.elpi".

Elpi Accumulate Db derive.param1.trivial.db.
Elpi Accumulate File "elpi/param1_trivial.elpi".

Elpi Accumulate Db derive.invert.db.
Elpi Accumulate File "elpi/invert.elpi".

Elpi Accumulate Db derive.idx2inv.db.
Elpi Accumulate File "elpi/idx2inv.elpi".

Elpi Accumulate Db derive.induction.db.
Elpi Accumulate File "elpi/induction.elpi".

Elpi Accumulate Db derive.bcongr.db.
Elpi Accumulate File "elpi/injection.elpi".
Elpi Accumulate File "elpi/bcongr.elpi".

Elpi Accumulate Db derive.eqK.db.
Elpi Accumulate File "elpi/discriminate.elpi".
Elpi Accumulate File "elpi/eqK.elpi".

Elpi Accumulate Db derive.eqcorrect.db.
Elpi Accumulate File "elpi/eqcorrect.elpi".

Elpi Accumulate File "elpi/eqOK.elpi".

Elpi Accumulate File "elpi/param2.elpi".
Elpi Accumulate Db derive.param2.db.

Elpi Accumulate File "elpi/lens.elpi".
Elpi Accumulate Db derive.lens.db.
Elpi Accumulate File "elpi/lens_laws.elpi".

Import PArith.
Local Open Scope positive_scope.
Elpi Accumulate Db derive.tag.db.
Elpi Accumulate File "elpi/tag.elpi".
Elpi Accumulate Db derive.fields.db.
Elpi Accumulate File "elpi/fields.elpi".
Elpi Accumulate Db derive.eqb.db.
Elpi Accumulate File "elpi/eqb.elpi".
Elpi Accumulate Db derive.eqbcorrect.db.
Elpi Accumulate File "elpi/eqbcorrect.elpi".
Close Scope positive_scope.

Elpi Accumulate File "elpi/derive.elpi".
Elpi Accumulate lp:{{

% runs P in a context where Coq #[attributes] are parsed
pred with-attributes i:prop.
with-attributes P :-
  attributes A,
  coq.parse-attributes A [
    att "verbose" bool,
    att "only" attmap,
  ] Opts, !,
  Opts => P.

main [str I, str Prefix] :- !,
  coq.locate I (indt GR),
  with-attributes (derive.main GR {calc (Prefix ^ "_")} ).

main [str I] :- !,
  coq.locate I (indt GR),
  coq.gref->id (indt GR) Tname,
  main [str I, str Tname].

main [indt-decl D] :- !,
  with-attributes (derive.decl+main D).

main _ :- usage.

usage :-
  coq.error "Usage:  derive <inductive type> [<prefix>]\n\tderive Inductive name Params : Arity := Constructors.".

}}.
Elpi Typecheck.
Elpi Export derive.

(* we derive the Coq prelude *)

Module Prelude.
Module Empty_set. derive Init.Datatypes.Empty_set "". End Empty_set.
Module unit. derive Init.Datatypes.unit "". End unit.
Module bool. derive Init.Datatypes.bool "". End bool.
Module nat. derive Init.Datatypes.nat "". End nat.
Module option. derive Init.Datatypes.option "". End option.
Module sum. derive Init.Datatypes.sum "". End sum.
Module prod. derive Init.Datatypes.prod "". End prod.
Module list. derive Init.Datatypes.list "". End list.
Module comparison. derive Init.Datatypes.comparison "". End comparison.
End Prelude.

Export Prelude.
