type symbol = LeafS of int | NodeS
type tree = Leaf of int | Node of tree * tree

val print_tree : tree -> unit
