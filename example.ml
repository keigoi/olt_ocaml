open Tree
open Olt_stream (* or. open Olt_tree for non-streamized version *)

(* make an input stream *)
let tree () = 
  to_stream
    (Node(Node(Leaf 1,Node(Leaf 2,Leaf 3)),Node(Node(Leaf 4,Leaf 5),Leaf 6)))


let print_symbols symbols = print_tree (rebuild_tree symbols)


(* map *)
let rec tree_map : 'p. (int->int) -> ((itree,'p) cons, 'p, otree, unit) monad = fun f ->
  tree_case 
    ~leaf:(fun n -> leaf_make (f n)) 
    ~node:(fun () -> node_make ~left:(tree_map f) ~right:(tree_map f))
;;

print_symbols (run_tree (tree ()) (tree_map (fun x -> x+1)));;
print_newline();;
(*
  Node (Node (Leaf 2, Node (Leaf 3, Leaf 4)), Node (Node (Leaf 5, Leaf 6), Leaf 7))
*)


(* increment leaves at each even depth *)
let rec inc_alt : 'p. unit -> ((itree, 'p) cons, 'p, otree, unit) monad = fun () ->
  let inc_alt_even () =
    tree_case
      ~leaf:(fun x -> leaf_make (x+1))
      ~node:(fun () -> node_make (inc_alt ()) (inc_alt ()))
  in
  tree_case
    ~leaf:(fun x -> leaf_make x)
    ~node:(fun () -> node_make (inc_alt_even ()) (inc_alt_even ()))
;;

print_symbols (run_tree (tree ()) (inc_alt ()));;
print_newline();;
(*
  Node (Node (Leaf 1, Node (Leaf 3, Leaf 4)), Node (Node (Leaf 5, Leaf 6), Leaf 6))
*)


(* sum of leaves *)
let rec sum : 'p. unit -> ((itree,'p)cons,'p,none,int) monad = fun () -> 
  tree_case 
    ~leaf:ret 
    ~node:(fun () -> sum () >>= fun x -> sum () >>= fun y -> ret (x+y))
;;

print_int (run (tree ()) (sum ()));;
print_newline();;
(*
  21
*)


(* tree algebra for tree folding (required since 'p differs on each tree_fold call) *)
type ('t,'a) tree_alg = 
    {fg: 'p. 
        ((int -> ('p, 'p, 't, 'a) monad) *
            ((unit -> ((itree, (itree, 'p) cons) cons, (itree, 'p) cons, 't, 'a) monad) ->
             (unit -> ((itree, 'p) cons, 'p, 't, 'a) monad) ->
             ((itree, (itree, 'p) cons) cons, 'p, 't, 'a) monad));
    }

(* tree folding *)
let rec tree_fold : 'p 't 'a. ('t,'a) tree_alg -> unit -> ((itree, 'p) cons, 'p, 't, 'a) monad = fun alg () ->
  tree_case
    ~leaf:(fun n -> fst alg.fg n)
    ~node:(fun () -> snd alg.fg (tree_fold alg) (tree_fold alg))

let tree_map2 f = 
  tree_fold 
    {fg=(fun n -> leaf_make (f n)),
        (fun m1 m2 -> node_make (m1 ()) (m2 ()))}
    ()

let sum2 () = 
  tree_fold 
    {fg=(fun n->ret n),
     (fun t1 t2 -> t1 () >>= fun x -> t2 () >>= fun y -> ret (x+y))}
    ()
;;

print_symbols (run_tree (tree ()) (tree_map2 (fun x -> x+1)));;
print_newline();;
(*
  Node (Node (Leaf 2, Node (Leaf 3, Leaf 4)), Node (Node (Leaf 5, Leaf 6), Leaf 7))
*)

print_int (run (tree ()) (sum2 ()));;
print_newline();;
(*
  21
*)

