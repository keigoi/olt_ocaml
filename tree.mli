type symbol = LeafS of int | NodeS
type tree = Leaf of int | Node of tree * tree

val print_tree : tree -> unit
val print_symbol : symbol -> unit
val parse_stream : symbol Stream.t -> tree
val to_stream : tree -> symbol Stream.t
val rebuild_tree : symbols:((symbol -> unit) -> unit) -> tree
