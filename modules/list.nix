{ lib }: rec {
  flatMap = f: xs: builtins.concatLists (map f xs);
  wrapIfNotList = x: if !builtins.isList x then [ x ] else x;
  singleton = x: [ x ];
}
