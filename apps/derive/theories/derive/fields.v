From elpi Require Import elpi.
From Coq Require Import PArith.
From elpi.apps Require Export derive.tag.

Register unit as elpi.derive.unit.

Local Open Scope positive_scope.

Elpi Db derive.fields.db lp:{{

% this is how one registers the fields_t, fields and construct[P]
% constants to an inductive and let other elpi commands use that piece of info
pred fields-for
  o:inductive,
  o:constant, % fields_t
  o:constant, % fields
  o:constant, % construct
  o:constant. % constructP

}}.

Elpi Command derive.fields.
Elpi Accumulate File "elpi/fields.elpi".
Elpi Accumulate Db derive.tag.db.
Elpi Accumulate Db derive.fields.db.
Elpi Accumulate lp:{{
  main [str I, str O] :- !, 
    coq.locate I (indt GR), 
    Prefix is O ^ "_",
    derive.fields.main GR Prefix _.

  main [str I] :- !, 
    coq.locate I (indt GR),
    coq.gref->id (indt GR) Tname,
    Prefix is Tname ^ "_",
    derive.fields.main GR Prefix _.

  main _ :- usage.
   
  usage :- coq.error "Usage: derive.fields <inductive name> [<prefix>]".

}}.
Elpi Typecheck.
