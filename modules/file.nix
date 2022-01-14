self:
with self; rec {
  getFilesRecursive = dir:
    builtins.foldl' (s1: s2: s1 // s2) { } (builtins.concatLists
      (builtins.attrValues (builtins.mapAttrs (name: type:
        if type == "directory" then
          builtins.attrValues
          (builtins.mapAttrs (name2: type2: { ${name + "/" + name2} = type2; })
            (getFilesRecursive (dir + "/${name}")))
        else [{
          ${name} = type;
        }]) (builtins.readDir dir))));
}
