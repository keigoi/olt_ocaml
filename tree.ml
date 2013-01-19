type symbol = LeafS of int | NodeS
type tree = Leaf of int | Node of tree * tree

let rec print_tree = function
  | Leaf n -> print_string "Leaf "; print_int n
  | Node (t1,t2) -> print_string "Node ("; print_tree t1; print_string ", "; print_tree t2; print_string ")"
