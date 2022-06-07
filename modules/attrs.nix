{ lib, ... }:
with builtins;
with lib; {
  guard = q: x: if q then x else null;
  guardNull = x: guard (x == null);
  attrsToList = let f = name: value: { inherit name value; };
  in mapAttrsToValues f;
  attrsToListRecursive = a:
    let
      f = name: value:
        if isAttrs value then
          map (g name) (attrsToListRecursive value)
        else [{
          inherit value;
          loc = [ name ];
        }];
      g = parent:
        { loc, value }: {
          inherit value;
          loc = [ parent ] ++ loc;
        };
    in concatLists (mapAttrsToValues f a);
  attrNamesRecursive = a:
    let f = { loc, ... }: loc;
    in map f (attrsToListRecursive a);
  listToAttrsRecursive = l:
    let f = { loc, value }: mkNestedAttrs loc value;
    in mergeAttrs (map f l);
  filterAttrs = f: a:
    listToAttrs (filter ({ name, value }: f name value) (attrsToList a));
  filterAttrNames = f: filterAttrs (_: f);
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
  mkNestedAttrs = path: value:
    if path == [ ] then
      value
    else {
      ${head path} = mkNestedAttrs (tail path) value;
    };
}
