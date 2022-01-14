self:
with self; rec {
  ifF = i: t: e: if i then t else e;
  select = p: f1: f2: x: if p x then f1 x else f2 x;
  tryExcept = { value, callback ? (x: x), fallback }:
    let attempt = builtins.tryEval value;
    in if attempt.success then callback attempt.value else fallback;
  fallback = fallback: value: tryExcept { inherit value fallback; };
}
