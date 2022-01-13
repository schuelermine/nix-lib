{ self }: rec {
  singletonIfNotList = x: if !builtins.isList x then [ x ] else x;
  singleton = x: [ x ];
}
