{ lib, ... }:
with builtins;
with lib; {
  cons = x: xs: [ x ] ++ xs;
  asCons = f1: f2: xs: cons (f1 (head xs)) (f2 (tail xs));
  asHead = f: xs: cons (f (head xs)) (tail xs);
  sandwich = x: xs: [ x ] ++ xs ++ [ x ];
  wrap = x: if isList x then x else [ x ];
}
