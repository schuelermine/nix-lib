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
  filter = p: mapX (k: v: { ${if p k v then k else null} = v; });
  flatten = flattenWith (_: x: x);
  flattenR = flattenRWith (_: x: x);
  flattenDot = flattenWith (x: y: "${x}.${y}");
  flattenRDot = flattenRWith (x: y: "${x}.${y}");
  flattenWith = f:
    mapX (k: v: if builtins.isAttrs v then mapOverNames (f k) v else v);
  flattenRWith = f:
    mapX (k: v:
      if builtins.isAttrs v then
        mapOverNames (f k) (flattenWithR f v)
      else {
        ${k} = v;
      });
  toItemsR = s:
    builtins.concatLists (mapToValues (name: value:
      if builtins.isAttrs value then
        map (item: item // { loc = [ name ] ++ item.loc; }) (toItemsR value)
      else [{
        inherit value;
        loc = [ name ];
      }]) s);
  navigate = path: set:
    if path == [ ] then
      set
    else
      navigate (builtins.tail path) set.${builtins.head path};
}
