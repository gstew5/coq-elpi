From elpi Require Import elpi.
From Coq Require Import PArith.

Register positive as elpi.derive.positive.

Local Open Scope positive_scope.

Elpi Db derive.tag.db lp:{{

% this is how one registers the tag function to an inductive and let other
% elpi commands use that piece of info
pred tag-for o:inductive, o:constant.

}}.

Elpi Command derive.tag.
Elpi Accumulate File "elpi/tag.elpi".
Elpi Accumulate Db derive.tag.db.
Elpi Accumulate lp:{{

  main [str S] :-
    std.assert! (coq.locate S (indt I)) "Not an inductive type",
    Prefix is S ^ "_",
    derive.tag.main I Prefix _.

}}.
Elpi Typecheck.
