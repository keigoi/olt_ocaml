An encoding of Ordered Linear Types in OCaml
=========

A proof-of-concept implementation of Ordered Linear Types in [OCaml](http://caml.inria.fr/ocaml/), for tree-processing programming [1].
For much more serious implementation, see [2] which translates OLT-typed OCaml code into plain OCaml one.

[1] Koichi Kodama, Kohei Suenaga, and Naoki Kobayashi, "Translation of Tree-processing Programs into Stream-processing Programs based on Ordered Linear Type," Journal of Functional Programming, 18(3), pp.331-371, 2008. A copy is available at http://www-kb.is.s.u-tokyo.ac.jp/~koba/publications.html

[2] X-P. X-P is a translator of tree-processing-style XML processing programs into stream-processing programs. http://www.fos.kuis.kyoto-u.ac.jp/~ksuenaga/x-p/

Build
-----
```
./make.sh
```

Files
-----

* tree.ml[i]: An definition of trees
* oLT.mli: The signature shared by multiple OLT implementations.
* olt_stream.ml[i]: An OLT implementaton which takes a stream of tree nodes as input, and a tree as output.
* example.ml: Examples

In addition to that, olt_tree.ml[i] provides alternative implementation that does not use streams.
