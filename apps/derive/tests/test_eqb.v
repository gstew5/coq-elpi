From elpi.apps Require Import derive.eqb.

From elpi.apps.derive.tests Require Import test_derive_stdlib test_tag test_fields.
Import test_derive_stdlib.Coverage test_tag.Coverage test_fields.Coverage.
    
Module Coverage.

Elpi derive.eqb empty.
Elpi derive.eqb unit.
Elpi derive.eqb peano.
Elpi derive.eqb option.
Elpi derive.eqb pair.
Elpi derive.eqb seq.
Elpi derive.eqb rose.
Fail Elpi derive.eqb nest.
Elpi derive.eqb w.
Fail Elpi derive.eqb vect.
Fail Elpi derive.eqb dyn.
Fail Elpi derive.eqb zeta.
Elpi derive.eqb beta.
Fail Elpi derive.eqb iota.
(* Elpi derive.eqb large. *)
(* TODO move this else where *)
(* Elpi Accumulate derive.eqb.db lp:{{eqb-for {{PrimInt63.int}} {{PrimInt63.eqb}}. }}. *)
(* Elpi Accumulate derive.eqb.db lp:{{eqb-for {{PrimFloat.int}} {{PrimFloat.eqb}}. }}. *)
Elpi derive.eqb prim_int.
Elpi derive.eqb prim_float.
Elpi derive.eqb fo_record.
Elpi derive.eqb pa_record.
Fail Elpi derive.eqb pr_record. (* fixme elaborate *)
Elpi derive.eqb dep_record.
Elpi derive.eqb enum.
Elpi Trace "eqb-for".
Elpi derive.eqb sigma_bool.
End Coverage.

Import Coverage.
Import PArith.

Notation eq_test T := (T -> T -> bool).

Check empty_eqb   : eq_test empty.
Check unit_eqb    : eq_test unit.
Check peano_eqb   : eq_test peano.
Check option_eqb  : forall A, eq_test A -> eq_test (option A).
Check pair_eqb    : forall A, eq_test A -> forall B, eq_test B -> eq_test (pair A B).
Check seq_eqb     : forall A, eq_test A -> eq_test (seq A).
Check rose_eqb    : forall A, eq_test A -> eq_test (rose A).
Fail Check nest_eqb.
Check w_eqb.   (* Do something but it is stupide*)
Fail Check vect_eqb    : forall A, eq_test A -> forall i, eq_test (vect A i).
Fail Check dyn_eqb.
Fail Check zeta_eqb : forall A, eq_test A -> eq_test (zeta A).
Check beta_eqb : forall A, eq_test A -> eq_test (beta A).
Fail Check iota_eqb : eq_test iota.
(* Check large_eqb   : eq_test large. *)
(* FIXME : the definition of prim_int_eqb_fields*)
Check prim_int_eqb    : eq_test prim_int.
Check prim_float_eqb    : eq_test prim_float.
Check fo_record_eqb : eq_test fo_record.

Check pa_record_eqb : forall A, eq_test A -> eq_test (pa_record A).
Fail Check pr_record_eqb : forall A, eq_test A -> eq_test (pr_record A).
Check enum_eqb : eq_test enum.
Check sigma_bool_eqb : eq_test sigma_bool.
