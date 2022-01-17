# nix-lib

## Introduction

Anselm Schüler’s nix-lib is a standalone library of useful tools, functions, combinators and utilities for [Nix](https://nixos.org/).

## Principles & Architecture

### Independence

nix-lib is explicitly intended not to depend on nixpkgs. At least since the introduction of flakes, Nix has moved away from viewing nixpkgs as the “default” repository. I believe that independent repositories shouldn’t have to depend on nixpkgs for basic functionality, and Nix’s `builtins` namespace is sorely lacking. I also think this seperation of concerns is more elegant, so I also use it in my NixOS configurations, which certainly do depend on nixpkgs.

### Flexibility

All of these principles, with the possible exception of the previous one, are subject to change. If you believe that nix-lib would benefit from abandoning or amending some of them, feel free to voice your opinion. In fact, most of the following principles merely outline the current working process and are not at all maxims.

### Versioning

At the moment, I take no effort to ensure any compatibility and do not use SemVer. It is assumed and recommended that you use a dependency management system such as Nix flakes that allows you to lock the version of nix-lib you are using.

### Structure

nix-lib is divided into modules. Each module is defined in a separate Nix file, which is a function that takes a `self` parameter. In `default.nix` (the “bootstrap”), all module files are combined by calling them on the result of the combination of the return value of the aforementioned call. This is similar to the NixOS module system and allows all modules to use functions defined in other modules.

### Naming

If a module is specific to a type or class of values, their functions operating on these or relating to them should not be named to reflect the type. It is instead assumed that such functions will be called as an element of the module, whose name should serve to indicate this part of the function’s identity.