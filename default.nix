{ nixpkgs ? throw "Nixpkgs not provided." }:
let
  load-module = args@{ lib, nixpkgs }:
    module:
    if builtins.isFunction module then
      load-module args (module args)
    else if builtins.isString module then
      load-module args (./modules + "/${module}")
    else if builtins.isPath module then
      load-module args (import module)
    else if builtins.isAttrs module then
      module
    else
      throw "Loading module failed at value ${module}";
  fix-modules = modules:
    let
      lib = builtins.foldl' (a: b: a // b) { }
        (builtins.map (load-module { inherit nixpkgs lib; }) modules);
    in lib;
  modules = builtins.attrNames (builtins.readDir ./modules);
in fix-modules modules
