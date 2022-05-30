{ nixpkgs ? throw "Nixpkgs not provided." }:
let
  load-module = deps@{ nixpkgs }:
    final: module:
    if builtins.isFunction module then
      load-module deps final (module final) null
    else if builtins.isString module then
      load-module deps final (./modules + "/${module}")
    else if builtins.isPath module then
      load-module deps final (import module)
    else if builtins.isAttrs module then
      module
    else
      throw "Loading module failed at value ${module}";
  fix-modules = modules:
    let
      final = builtins.foldl' (a: b: a // b) { }
        (builtins.map (load-module { inherit nixpkgs; } final) modules);
    in final;
  modules = builtins.attrNames (builtins.readDir ./modules);
in fix-modules modules
