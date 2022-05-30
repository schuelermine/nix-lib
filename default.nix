{ nixpkgs ? throw "Nixpkgs not provided." }:
let
  load-module = args@{ lib, nixpkgs }:
    final: module:
    if builtins.isFunction module then
      load-module args (module args) null
    else if builtins.isString module then
      load-module args final (./modules + "/${module}")
    else if builtins.isPath module then
      load-module args final (import module)
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
