let
  lib = builtins.foldl' (a1: a2: a1 // a2) { } (builtins.attrValues
    (builtins.mapAttrs (k: v:
      if k != "default.nix" && v == "regular" then {
        ${builtins.elemAt (builtins.match "(.*)\\.nix" k) 0} =
          import (./. + "/${k}") { inherit lib; };
      } else
        { }) (builtins.readDir ./.)));
in lib
