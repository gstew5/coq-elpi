From elpi.apps Require Import derive.eqbcorrect.

From elpi.apps.derive.tests Require Import test_derive_stdlib test_tag test_fields test_eqb test_induction 
                                           test_param1 test_param1_inhab test_param1_functor.
Import test_derive_stdlib.Coverage 
       test_tag.Coverage 
       test_fields.Coverage
       test_eqb.Coverage 
       test_induction.Coverage 
       test_param1.Coverage 
       test_param1_functor.Coverage 
       test_param1_inhab.Coverage.
    
Module Coverage.

(* Elpi Trace (* "derive.eqbcorrect.*" "derive.param1.functor.*" "correct-lemma-for" *) "param1-functor-for". *)
Elpi derive.eqbcorrect empty.  (* No induction principle *) 
Elpi derive.eqbcorrect unit. 
Elpi derive.eqbcorrect peano.
Elpi derive.eqbcorrect option.
Elpi derive.eqbcorrect pair.
Elpi derive.eqbcorrect seq.
Elpi derive.eqbcorrect rose.
Fail Elpi derive.eqbcorrect nest. (* Maybe fixable *)
Fail Elpi derive.eqbcorrect w.    (* Not fixable *)
Fail Elpi derive.eqbcorrect vect. (* Can be done *)
Fail Elpi derive.eqbcorrect dyn.  (* Not Fixable *)
Fail Elpi derive.eqbcorrect zeta. (* FIXME *)
Elpi derive.eqbcorrect beta. 
Fail Elpi derive.eqbcorrect iota.
Fail Elpi derive.eqbcorrect prim_int.
Fail Elpi derive.eqbcorrect prim_float.
Fail Elpi derive.eqbcorrect fo_record.
Fail Elpi derive.eqbcorrect pa_record.
Fail Elpi derive.eqbcorrect pr_record. 
Fail Elpi derive.eqbcorrect dep_record.
Elpi derive.eqbcorrect enum.
Fail Elpi derive.eqbcorrect sigma_bool. (* A lot is missing for this one *)

End Coverage.
Import Coverage.
Import PArith.

