From Coq Require Import ssreflect ssrfun ssrbool.
From mathcomp Require Import eqtype.
Require Import eqb_core_defs.
Require Export eqb eqbcorrect.

Elpi Command derive.eqbP.
Elpi Accumulate Db derive.eqcorrect.db.
Elpi Accumulate Db derive.eqb.db.
Elpi Accumulate File "elpi/eqbP.elpi".
Elpi Accumulate lp:{{
 main [str I, str O] :- !, 
    coq.locate I (indt GR), 
    Prefix is O ^ "_",
    derive.eqbP.main GR Prefix _.

  main [str I] :- !, 
    coq.locate I (indt GR),
    coq.gref->id (indt GR) Tname,
    Prefix is Tname ^ "_",
    derive.eqbP.main GR Prefix _.

  main _ :- usage.
   
  usage :- coq.error "Usage: derive.eqb <inductive name> [<prefix>]".

}}.
Elpi Typecheck.
