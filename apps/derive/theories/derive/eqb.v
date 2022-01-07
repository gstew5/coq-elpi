From elpi Require Import elpi.
From Coq Require Import PArith.

Require Import eqb_core_defs.
Require Export tag fields.

Register eqb_body as elpi.derive.eqb_body.

Elpi Db derive.eqb.db lp:{{

pred eqb-for
  o:term, % type
  o:term. % eqb_type

pred eqb-fields
  o:term, % type
  o:term. % eq_fields_type


}}.

Elpi Command derive.eqb.
Elpi Accumulate File "elpi/fields.elpi".
Elpi Accumulate File "elpi/eqb.elpi".
Elpi Accumulate Db derive.tag.db.
Elpi Accumulate Db derive.fields.db.
Elpi Accumulate Db derive.eqb.db.
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
