From Coq Require Import ssreflect ssrfun ssrbool Eqdep_dec.
From elpi Require Import elpi induction param1_inhab eqb_core_defs tag fields eqb.

Ltac eqb_correct_on__solver :=
  by repeat (
    try case/andP; 
    match reverse goal with 
    | H : @eqb_core_defs.eqb_correct_on _ _ _ |- _ => move=> /=/H{H}->    (* FIXME Enrico : it does not work (in test_eqbcorrect) if we remove use the long path: i.e @eqb_core_defs.eqb_correct_on *)
    end (*;
    f_equal => //; apply (@UIP_dec bool Bool.bool_dec) *)
  ).

Ltac eqb_refl_on__solver :=
  rewrite /eqb_fields_refl_on /=;
  by repeat (reflexivity || apply/andP; split; assumption).
      
Elpi Command derive.eqbcorrect.
Elpi Accumulate Db derive.tag.db.
Elpi Accumulate Db derive.eqb.db.
Elpi Accumulate Db derive.fields.db.
Elpi Accumulate Db derive.eqbcorrect.db.
Elpi Accumulate Db derive.induction.db.
Elpi Accumulate Db derive.param1.db.
Elpi Accumulate Db derive.param1.inhab.db.
Elpi Accumulate File "elpi/eqbcorrect.elpi".
Elpi Accumulate File "paramX-lib.elpi". 
Elpi Accumulate File "elpi/param1.elpi".
Elpi Accumulate lp:{{
  main [str I, str O] :- !, 
    coq.locate I (indt GR), 
    Prefix is O ^ "_",
    derive.eqbcorrect.main GR Prefix _.

  main [str I] :- !, 
    coq.locate I (indt GR),
    coq.gref->id (indt GR) Tname,
    Prefix is Tname ^ "_",
    derive.eqbcorrect.main GR Prefix _.

  main _ :- usage.
   
  usage :- coq.error "Usage: derive.eqbcorrect <inductive name> [<prefix>]".

}}.
Elpi Typecheck.
