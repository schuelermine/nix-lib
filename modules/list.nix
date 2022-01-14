{ self }: rec {
  singleton = x: [ x ];
  singletonIfNotList = x: if !builtins.isList x then [ x ] else x;
  isSingleton = xs: builtins.length xs == 1;
}
