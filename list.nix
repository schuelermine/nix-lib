{ lib }: rec {
  flatMap = f: xs: builtins.concatLists (map f xs);
  mkList = x: if !builtins.isList x then [ x ] else x;
  singleton = x: [ x ];
}
