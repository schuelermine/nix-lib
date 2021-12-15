{
  outputs = { self }:
    builtins.foldl' (a1: a2: a1 // a2) { } (builtins.attrValues
      (builtins.mapAttrs (k: v: {
        ${builtins.elemAt (builtins.match "(.*)\\.nix" k) 0} =
          import (./modules + "/${k}") { inherit self; };
      }) (builtins.readDir ./modules)));
}
