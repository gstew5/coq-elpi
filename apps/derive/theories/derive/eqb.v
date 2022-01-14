From elpi Require Import elpi.
From Coq Require Import ssrbool.
From Coq Require Import PArith.

Require Import eqb_core_defs.
Require Export tag fields.

Register eqb_body as elpi.derive.eqb_body.

Elpi Db derive.eqbcorrect.db lp:{{

  pred eqcorrect-for
    o:inductive,
    o:constant, % correct
    o:constant. % reflexive 

  :index(2)
  pred correct-lemma-for i:term, o:term.

  :index(2)
  pred refl-lemma-for i:term, o:term. 

}}.

Elpi Db derive.eqb.db lp:{{

pred eqb-for
  o:term, % type
  o:term. % comparison function

pred eqb-fields
  o:term, % type
  o:term. % eq_fields_type

eqb-for {{ @is_true lp:X }} {{ fun (_ _ : @is_true lp:X) => true }}.
eqb-for {{ @eq bool lp:X true }} {{ fun (_ _ : @eq bool lp:X true) => true }}.
   /* Generalize over bool and true, have a list of uip, i.e use  eqcorrect-for */ 
eqb-for T X :- whd1 T T1, !, eqb-for T1 X. 

}}.

Elpi Command derive.eqb.

Elpi Accumulate Db derive.tag.db.
Elpi Accumulate Db derive.fields.db.
Elpi Accumulate Db derive.eqb.db.
Elpi Accumulate Db derive.eqbcorrect.db.
Elpi Accumulate File "elpi/fields.elpi".
Elpi Accumulate File "elpi/eqb.elpi".

Elpi Accumulate lp:{{

  main [str I, str O] :- !, 
    coq.locate I (indt GR), 
    Prefix is O ^ "_",
    derive.eqb.main GR Prefix _.

  main [str I] :- !, 
    coq.locate I (indt GR),
    coq.gref->id (indt GR) Tname,
    Prefix is Tname ^ "_",
    derive.eqb.main GR Prefix _.

  main _ :- usage.
   
  usage :- coq.error "Usage: derive.eqb <inductive name> [<prefix>]".

}}.
Elpi Typecheck.
