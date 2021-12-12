{ lib }: rec {
  getFilesR = dir:
    builtins.concatLists (builtins.attrValues (builtins.mapAttrs (name: type:
      if builtins.elem type [ "symlink" "directory" ] then
        let attempt = builtins.tryEval (getFilesR (dir + "/${name}"));
        in if attempt.success then
          map (name2: name + "/" + name2) attempt.value
        else
          [ ]
      else
        [ name ]) (builtins.readDir dir)));
}
