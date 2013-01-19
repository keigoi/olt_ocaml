type symbol = LeafS of int | NodeS
type tree = Leaf of int | Node of tree * tree

let rec print_tree = function
  | Leaf n -> print_string "Leaf "; print_int n
  | Node (t1,t2) -> print_string "Node ("; print_tree t1; print_string ", "; print_tree t2; print_string ")"

let rec print_symbol = function
  | LeafS n -> print_string "LeafS "; print_int n; print_string "; "
  | NodeS -> print_string "NodeS; "

let to_stream t : symbol Stream.t = 
  let rec flatten_tree : tree -> symbol list = 
    function 
      | Leaf n -> [LeafS n]
      | Node (t1,t2) -> NodeS :: List.append (flatten_tree t1) (flatten_tree t2)
  in Stream.of_list (flatten_tree t)

let parse_stream (st:symbol Stream.t) : tree =
  let rec parse () : tree =
    match Stream.next st with
      | LeafS n -> Leaf n
      | NodeS -> 
          let t1 = parse () in
          let t2 = parse () in
          Node(t1,t2)
  in parse ()

let rebuild_tree ~(symbols:((symbol -> unit) -> unit)) : tree =
  let buf = ref [] in
  let writer s = buf := s :: !buf 
  in
  symbols writer;
  parse_stream (Stream.of_list (List.rev !buf))
