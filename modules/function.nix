self:
with self; rec {
  fix = f: let x = f x; in x;
  compose = f1: f2: x: f1 (f2 x);
  const = x: _: x;
  omega = f: f f;
  flip = f: x1: x2: f x2 x1;
}
