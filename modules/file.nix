self:
with self; rec {
  readDirRecursive = readDirRecursiveSep "/";
  readDirRecursiveSep = sep:
    readDirRecursiveWith (dir: name: "${dir}${sep}${name}");
  readDirRecursiveWith = f: dir:
    builtins.foldl' (s1: s2: s1 // s2) { } (builtins.concatLists
      (builtins.attrValues (builtins.mapAttrs (name: type:
        if type == "directory" then
          builtins.attrValues
          (builtins.mapAttrs (name2: type2: { ${name + "/" + name2} = type2; })
            (readDirRecursiveWith (f dir name)))
        else [{
          ${name} = type;
        }]) (builtins.readDir dir))));
}
