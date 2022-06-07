let
  preCall = with builtins;
    f:
    let
      g = a:
        if isAttrs a then
          let x = f a;
          in {
            __functor = self: b: g b;
          } // x // {
            ${if x ? __functor then null else "__functionArgs"} =
              functionArgs f;
          }
        else
          f a;
    in g { };
in preCall ({ pkgs ? throw "Package set not provided"
  , nixpkgsLib ? throw "Nixpkgs library not provided", includeBuiltins ? true
  , includeNixpkgsLib ? (builtins.tryEval nixpkgsLib).success }:
  let
    load-module = args@{ lib, nixpkgsLib }:
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
          (builtins.map (load-module { inherit nixpkgsLib lib; }) modules);
      in lib;
    modules = builtins.attrNames (builtins.readDir ./modules)
      ++ (if includeBuiltins then [ builtins ] else [ ])
      ++ (if includeNixpkgsLib then [ nixpkgsLib ] else [ ]);
  in fix-modules modules)
