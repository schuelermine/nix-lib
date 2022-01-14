self:
with self; rec {
  merge = s1: s2: s1 // s2;
  toList = mapToValues (name: value: { inherit name value; });
  toItems = mapToValues (k: v: [ k v ]);
  itemToPair = s: [ s.name s.value ];
  fromItem = s: { ${s.name or null} = s.value; };
  singleton = k: v: { ${k} = v; };
  mergeList = builtins.foldl' merge { };
  mapViaItems = f: s: builtins.listToAttrs (mapToValues f s);
  mapX = f: s: mergeList (mapToValues f s);
  mapToValues = f: s: builtins.attrValues (builtins.mapAttrs f s);
  mapOverValues = f: builtins.mapAttrs (_: f);
  mapOverNames = f: mapX (k: v: { ${f k} = v; });
  flatten = flattenWith (_: x: x);
  flattenR = flattenRWith (_: x: x);
  flattenWith = f:
    mapX (k: v: if builtins.isAttrs v then mapOverNames (f k) v else v);
  flattenRWith = f:
    mapX (k: v:
      if builtins.isAttrs v then
        mapOverNames (f k) (flattenWithR f v)
      else {
        ${k} = v;
      });
}
