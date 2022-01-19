self:
with self; rec {
  readDirRCollapsed = readDirRCollapsedSep "/";
  readDirRCollapsedSep = sep:
    readDirRCollapsedWith (dir: name: "${dir}${sep}${name}");
  readDirRCollapsedWith = f: dir:
    builtins.foldl' (s1: s2: s1 // s2) { } (builtins.concatLists
      (builtins.attrValues (builtins.mapAttrs (name: type:
        if type == "directory" then
          builtins.attrValues
          (builtins.mapAttrs (name2: type2: { ${f name name2} = type2; })
            (readDirRCollapsedWith f (dir + "/${name}")))
        else [{
          ${name} = type;
        }]) (builtins.readDir dir))));
  readDirR = dir:
    builtins.mapAttrs (name: type:
      if type == "directory" then readDirR (dir + "/${name}") else type)
    (builtins.readDir dir);
  readDirRFlat = func.compose attrs.toLocListR readDirR;
}
