include module type of OLT 
  (* input tree is a stream of tree tokens *)
  with type itree = Tree.symbol Stream.t 
  (* output tree is a function that writes symbols to a given writer function *)
  and type otree = (Tree.symbol -> unit) -> unit 

