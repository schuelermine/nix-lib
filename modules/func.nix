self:
with self; rec {
  id = x: x;
  const = x: _: x;
  comp = f1: f2: x: f1 (f2 x);
  flip = f: x1: x2: f x2 x1;
  fix = f: let x = f x; in x;
  self = f: f f;
  diag = f: x: f x x;
  com = rec {
    I = x: x;
    S = x: y: z: x z (y z);
    K = x: _: x;
    K' = _: x: x;
    B = x: y: z: x (y z);
    B' = x: y: z: y (x z);
    C = x: y: z: x z y;
    W = x: y: x y y;
    O = x: x x;
    Y = f: (x: f (x x)) (x: f (x x));
    Y' = (x: y: x y x) (x: y: x (y x y));
    T = (x: y: y (x x y)) (x: y: y (x x y));
    Z = f: (x: f (v: x x v)) (x: f (v: x x v));
    N = B M (B (B M) B);
  };
}
