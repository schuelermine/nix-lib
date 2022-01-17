# nix-lib

## Introduction

Anselm Schüler’s nix-lib is a standalone library of useful tools, functions, combinators and utilities for [Nix](https://nixos.org/).

**Warning: You should read the section “Principles & Architecture/Versioning” before integrating nix-lib into your project.**

## Usage

### Importing

To use nix-lib, you need to import it into your nix project.

You can do that manually by copying the entire project directory, and then running `import` on the path to that directory, which will load `default.nix`.

nix-lib is also a flake, which means you can easily import it into your flakes by specifiying it as an input. You can use the flake URL `github:schuelermine/nix-lib`. You could also get the flake in an impure non-flake Nix project by using `builtins.getFlake`.

Here is an example flake that depends on nix-lib:

```nix
{
  inputs.nix-lib.url = "github:schuelermine/nix-lib";
  outputs = { nix-lib, self }:
    nix-lib.attrs.singleton "default" "Hello, World!";
}
```

### Content

Whether you use `import` or flakes, the value you get will be an attribute set with elements for each module of nix-lib. If you get nix-lib via a flake, all of these attributes are at the top-level of the flake. Name conflicts with flake attributes such as `narHash` are avoided.

## Principles & Architecture

### Independence

nix-lib is explicitly intended not to depend on nixpkgs. At least since the introduction of flakes, Nix has moved away from viewing nixpkgs as the “default” repository. I believe that independent repositories shouldn’t have to depend on nixpkgs for basic functionality, and Nix’s `builtins` namespace is sorely lacking. I also think this seperation of concerns is more elegant; I use it in my NixOS configurations, which certainly do depend on nixpkgs.

### Flexibility

All of these principles, with the possible exception of the previous one, are subject to change. If you believe that nix-lib would benefit from abandoning or amending some of them, feel free to voice your opinion. In fact, most of the following principles merely outline the current working process and are not at all maxims.

### Versioning

At the moment, I take no effort to ensure any compatibility and do not use SemVer. It is assumed and recommended that you use a dependency management system such as Nix flakes that allows you to lock the version of nix-lib you are using.

### Structure

nix-lib is divided into modules. Each module is defined in a separate Nix file, which is a function that take a single parameter. In `default.nix` (the “bootstrap”), all module files are combined by calling them on the result of the combination of the return value of the aforementioned call. This is similar to the NixOS module system and allows all modules to use functions defined in other modules.

### Naming

If a module is specific to a type or class of values, their functions operating on these or relating to them should not be named to reflect the type. It is instead assumed that such functions will be called as an element of the module, whose name should serve to indicate this part of the function’s identity.

For instance, `attrs.merge` is not named `mergeAttrs`.