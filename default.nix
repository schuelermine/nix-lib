let
  lib = builtins.foldl' (a1: a2: a1 // a2) { } (builtins.attrValues
    (builtins.mapAttrs (k: v: {
      ${builtins.elemAt (builtins.match "(.*)\\.nix" k) 0} =
        import (./. + "/${k}") { inherit lib; };
    }) (builtins.readDir ./modules)));
in lib
