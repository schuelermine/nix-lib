{ lib, ... }:
with builtins;
with lib; rec {
  guard = q: x: if q then x else null;
  attrsToList = let f = key: value: { inherit key value; };
  in mapAttrsToValues f;
  filterAttrs = f: a:
    listToAttrs (filter ({ name, value }: f name value) (attrsToList a));
  filterAttrNames = f: a:
    listToAttrs (filter ({ name, ... }: f name) (attrsToList a));
  mergeAttrs = foldl' (a: b: a // b) { };
  mapAttrValues = f: mapAttrs (_: f);
  mapAttrNames = f: mapAttrsToAttrs (k: v: { ${f k} = v; });
  mapAttrsToValues = f: a: attrValues (mapAttrs f a);
  mapAttrsToAttrs = f: a: mergeAttrs (mapAttrsToValues f a);
  getAttrDesc = k: a:
    if a ? ${k} then {
      key = k;
      value = a.${k};
    } else
      null;
  combineWith = f: a: b:
    let g = k: _: f (getAttrDesc k a) (getAttrDesc k b);
    in mapAttrs g (a // b);
  flattenAttrs = let f = k: v: if isAttrs v then v else { ${k} = v; };
  in mapAttrsToAttrs f;
}
