#!/bin/sh
set -v
rm -f a.out
ocamlc -o a.out oLT.mli tree.mli olt_stream.mli olt_tree.mli tree.ml olt_stream.ml olt_tree.ml example.ml
./a.out
