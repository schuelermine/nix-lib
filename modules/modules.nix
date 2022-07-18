{ lib, nixpkgsLib, ... }:
with lib;
with nixpkgsLib;
with builtins; {
  mkRenamedSuperoptionModules = n1: n2: k:
    map (g:
      let gs = wrap g;
      in mkRenamedOptionModule (wrap n1 ++ gs) (wrap n2 ++ gs)) (wrap k);
  mkProvidesModule = args@{ prefix ? [ ], packagesLoc ? [ "home" "packages" ]
    , onlyIf ? true, ... }:
    { config, ... }:
    let
      args' = removeAttrs args [ "prefix" "packagesLoc" "onlyIf" ];
      cfg = attrByPath prefix impossible config;
    in {
      options = mkNestedAttrs prefix (mkProvidesOption args');
      config = mkNestedAttrs packagesLoc
        (optional (cfg.package != null && onlyIf) cfg.package);
    };
}
