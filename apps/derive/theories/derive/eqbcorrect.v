From Coq Require Import ssreflect ssrfun ssrbool.
From elpi Require Import elpi induction param1_inhab eqb_core_defs tag fields eqb.

(*Require Import eqb_core_defs.
Require Export tag fields eqb. *)

Ltac eqb_correct_on__solver :=
  by repeat (
    try case/andP; 
    match reverse goal with H : @eqb_correct_on _ _ _ |- _ => move=> /=/H{H}-> end).

Ltac eqb_refl_on__solver :=
  rewrite /eqb_fields_refl_on /=;
  by repeat (reflexivity || apply/andP; split; assumption).

Elpi Db derive.eqbcorrect.db lp:{{

  pred eqcorrect-for
    o:inductive,
    o:constant, % correct
    o:constant. % reflexive
  /* JC HERE 

  pred eqb-correct-aux-for o:term, o:term.
  eqb-correct-aux-for
    {{ @eq_correct_on lp:T lp:F }}
    {{ (fun (a : lp:T) (H : @eq_correct_on lp:T lp:F) => H) }}.
  %
  eqb-correct-aux-for
    {{ option_is_option lp:T (@eqb_correct_on _ _) }}
    {{ (fun (a : lp:T) (H : option_eqb_correct_aux lp:T lp:Cmp }}.
  eqb-correct-aux-for
    {{ option_is_option lp:T lp:P }}
    {{ fun x H => option_is_option_functor lp:T _ (@eqb_correct_on _ _) (lp:Rec x H) }} :-
    eqb-correct-aux-for P Rec.

  
  eqb-correct-aux-for {{ list_is_list lp:A lp:P }} {{ list_eqb_correct_aux ... }} :-
    eqb-correct-aux-for P X.

    option_is_option (list A) (list_is_list A (eqb_correct_on A FA))
*/

}}.
      
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
