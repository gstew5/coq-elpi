From Coq Require Import ssreflect. (* FIXME Enrico: the tactic eqb_correct_on__solver does not work if the ssreflect is not require *)
From elpi.apps Require Import derive.eqbcorrect.

From elpi.apps.derive.tests Require Import test_derive_stdlib test_tag test_fields test_eqb test_induction 
                                           test_param1 test_param1_inhab.
Import test_derive_stdlib.Coverage test_tag.Coverage test_fields.Coverage
       test_eqb.Coverage test_induction.Coverage test_param1.Coverage test_param1_inhab.Coverage.
    
Module Coverage.

(* Fail Elpi derive.eqbcorrect empty.  (* No induction principle *) *)
Elpi derive.eqbcorrect unit.
Elpi derive.eqbcorrect peano.
Fail Elpi derive.eqbcorrect option.
Fail Elpi derive.eqbcorrect pair.
Fail Elpi derive.eqbcorrect seq.
Fail Elpi derive.eqbcorrect rose.
Fail Elpi derive.eqbcorrect nest.
Fail Elpi derive.eqbcorrect w.
Fail Elpi derive.eqbcorrect vect.
Fail Elpi derive.eqbcorrect dyn.
Fail Elpi derive.eqbcorrect zeta.
Fail Elpi derive.eqbcorrect beta.
Fail Elpi derive.eqbcorrect iota.
Fail Elpi derive.eqbcorrect prim_int.
Fail Elpi derive.eqbcorrect prim_float.
Fail Elpi derive.eqbcorrect fo_record.
Fail Elpi derive.eqbcorrect pa_record.
Fail Elpi derive.eqbcorrect pr_record. 
Fail Elpi derive.eqbcorrect dep_record.
Elpi derive.eqbcorrect enum.
Fail Elpi derive.eqbcorrect sigma_bool.
End Coverage.
Import Coverage.
Import PArith.

