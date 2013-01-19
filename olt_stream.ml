include Tree

type ('hd,'tl) cons = Dummy
type nil

type none = None

type ('p,'q,'t,'a) monad = symbol Stream.t -> 't * 'a

let ret a = fun _ -> None, a
let (>>=) f g = fun s -> g (snd (f s)) s
let (>>) f g = f >>= (fun _ -> g)

type itree = symbol Stream.t
type otree = tree

let run t f = snd (f t)
let run_tree t f = fst (f t)

let tree_case ~leaf ~node = fun s ->
  match Stream.next s with
    | LeafS n -> leaf n s
    | NodeS -> node () s

let node_make ~left ~right = fun s ->
  let t1,_ = left s in
  let t2,_ = right s in
  Node(t1,t2),()

let leaf_make n = fun s -> Leaf n, ()
