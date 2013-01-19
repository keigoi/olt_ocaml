include Tree

type ('hd,'tl) cons = Cons of 'hd * 'tl
type nil = Nil

type none = None

type ('p,'q,'t,'a) monad = 'p -> 'q * 't * 'a

let ret a p = p, None, a
let (>>=) f g p = 
  match f p with
    | q, _, a -> g a q
let (>>) f g = f >>= (fun () -> g)

type itree = tree
type otree = tree

let run t m =
  match m (Cons(t,Nil)) with
    | _, _, a -> a

let run_tree t m =
  match m (Cons(t,Nil)) with
    | _, t, _ -> t

let tree_case ~leaf ~node = fun (Cons(t,p)) ->
  match t with
    | Leaf n -> leaf n p
    | Node (t1, t2) -> node () (Cons(t1,Cons(t2,p)))

let node_make ~left ~right = fun p ->
  match left p with
    | q, t1, _ ->
        match right q with
          | r, t2, _ -> r, (Node(t1,t2)), ()

let leaf_make n p = p, Leaf n, ()
