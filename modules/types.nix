{ lib, nixpkgsLib }:
with lib;
with nixpkgsLib;
with builtins; {
  mkProvidesType = args@{ extraModules ? [ ], ... }:
    types.submoduleWith {
      modules = [{
        options = mkProvidesOptionSet (removeAttrs args [ "extraModules" ]);
      }] ++ extraModules;
    };
}
