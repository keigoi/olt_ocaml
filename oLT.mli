type (+'hd, +'tl) cons
type nil
type none

type ('p,'q,'t,'a) monad
val ret : 'a -> ('p, 'p, none, 'a) monad
val (>>=) : ('p,'q,_,'a) monad -> ('a -> ('q,'r,'t,'b) monad) -> ('p,'r,'t,'b) monad
val (>>) : ('p,'q,_,unit) monad -> ('q,'r,'t,'b) monad -> ('p,'r,'t,'b) monad

type itree
type otree

val run : itree -> ((itree,nil) cons, nil, none, 'a) monad -> 'a
val run_tree : itree -> ((itree,nil) cons, nil, otree, unit) monad -> otree

val tree_case : 
  leaf:(int -> ('p, 'q, 't, 'a) monad) -> 
  node:(unit -> ((itree, (itree, 'p) cons) cons, 'q, 't, 'a) monad) -> 
  ((itree, 'p) cons, 'q, 't, 'a) monad

val node_make : 
  left:('p, 'q, otree, unit) monad -> 
  right:('q, 'r, otree, unit) monad -> 
  ('p, 'r, otree, unit) monad

val leaf_make : int -> ('p, 'p, otree, unit) monad
