{ self }: rec {
  merge = s1: s2: s1 // s2;
  toList = mapToValues (k: v: {
    name = k;
    value = v;
  });
  toItems = mapToValues (k: v: [ k v ]);
  itemToPair = s: [ s.name s.value ];
  fromItem = s: { ${s.name or null} = s.value; };
  singleton = k: v: { ${k} = v; };
  mergeList = builtins.foldl' merge { };
  mapViaItems = f: s: builtins.listToAttrs (mapToValues f s);
  mapX = f: s: mergeList (mapToValues f s);
  mapToValues = f: s: builtins.attrValues (builtins.mapAttrs f s);
  mapOverValues = f: builtins.mapAttrs (k: f);
  mapOverNames = f: mapX (k: v: { ${f k} = v; });
  flatten = flattenWith (x1: x2: x2);
  flattenWith = f: mapX (k: mapOverNames (f k));
}
