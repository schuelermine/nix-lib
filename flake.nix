{
  outputs = { self }:
    builtins.foldl' (a1: a2: a1 // a2) { } (builtins.attrValues
      (builtins.mapAttrs (k: _: {
        ${builtins.elemAt (builtins.match "(.*)\\.nix" k) 0} =
          import (./modules + "/${k}") self.outputs;
      }) (builtins.readDir ./modules)));
}
