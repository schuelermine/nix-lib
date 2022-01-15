let
  dir = ./modules;
  self = builtins.foldl' (a1: a2: a1 // a2) { } (builtins.attrValues
    (builtins.mapAttrs (k: _: {
      ${
        let matches = (builtins.match "(.*)\\.nix" k);
        in if matches != null && builtins.length matches == 1 then
          builtins.head matches
        else
          null
      } = import (dir + "/${k}") self;
    }) (builtins.readDir dir)));
in self
