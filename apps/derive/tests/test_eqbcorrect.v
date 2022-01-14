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
Elpi derive.eqbcorrect box_peano.
Elpi derive.eqbcorrect rose.
Elpi derive.eqbcorrect rose_p.
Fail Elpi derive.eqbcorrect nest. (* Maybe fixable *)
Fail Elpi derive.eqbcorrect w.    (* Not fixable *)
Fail Elpi derive.eqbcorrect vect. (* Can be done *)
Fail Elpi derive.eqbcorrect dyn.  (* Not Fixable *)
Fail Elpi derive.eqbcorrect zeta. (* FIXME *)
Elpi derive.eqbcorrect beta.
Fail Elpi derive.eqbcorrect iota.

(* FIXME: how to do this properly *)
Lemma int_eqb_correct_aux : forall (n:PrimInt63.int), param1.is_uint63 n -> eqb_correct_on Uint63.eqb n.
Proof. move=> n _; apply /Uint63.eqb_correct. Qed.

Lemma int_eqb_refl_aux : forall (n:PrimInt63.int), param1.is_uint63 n -> eqb_refl_on Uint63.eqb n.
Proof. move=> n _; apply /Uint63.eqb_refl. Qed.

Elpi Accumulate derive.eqbcorrect.db lp:{{correct-lemma-for {{PrimInt63.int}} {{int_eqb_correct_aux}}. }}.
Elpi Accumulate derive.eqbcorrect.db lp:{{refl-lemma-for {{PrimInt63.int}} {{int_eqb_refl_aux}}. }}.

Elpi derive.eqbcorrect prim_int.
Fail Elpi derive.eqbcorrect prim_float.
Elpi derive.eqbcorrect fo_record.
Elpi derive.eqbcorrect pa_record.
Fail Elpi derive.eqbcorrect pr_record. 
Fail Elpi derive.eqbcorrect dep_record.
Elpi derive.eqbcorrect enum.
Fail Elpi derive.eqbcorrect sigma_bool. (* A lot is missing for this one *)

End Coverage.
Import Coverage.
Import PArith.

