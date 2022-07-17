{ lib, ... }:
with builtins;
with lib; {
  id = x: x;
  const = x: _: x;
  compose = f: g: x: f (g x);
  flip = f: x: y: f y x;
  fix = f: let x = f x; in x;
  preCall = f: i:
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
    in g i;
}
