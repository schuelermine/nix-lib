let
  self = builtins.foldl' (a1: a2: a1 // a2) { } (builtins.attrValues
    (builtins.mapAttrs (k: _: {
      ${builtins.head (builtins.match "(.*)\\.nix" k)} =
        import (./modules + "/${k}") self;
    }) (builtins.readDir ./modules)));
in self
