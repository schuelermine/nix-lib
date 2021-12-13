{ lib }: rec {
  fix = f: let x = f x; in x;
  compose = f: g: x: f (g x);
}
