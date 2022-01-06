From elpi Require Import elpi.
From Coq Require Import PArith.
From elpi.apps Require Export derive.tag.
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

  main [str S] :-
    std.assert! (coq.locate S (indt I)) "Not an inductive type",
    Prefix is S ^ "_",
    derive.fields.main I Prefix _.

}}.
Elpi Typecheck.
