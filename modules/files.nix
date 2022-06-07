{ lib, ... }:
with lib; {
  readDirFiles = dir:
    let
      dirContents = readDir dir;
      f = file: type: {
        ${lib.guard (type == "regular") file} = readFile "${dir}/${file}";
      };
    in mapAttrsToAttrs f dirContents;
  readDirFilesRecursive = dir:
    let
      dirContents = readDir dir;
      f = file: type:
        let
          target = "${dir}/${file}";
          readable = type == "directory" || type == "regular";
          content = if type == "directory" then
            readDirFilesRecursive target
          else if type == "regular" then
            readFile target
          else
            null;
        in { ${lib.guard readable file} = content; };
    in mapAttrsToAttrs f dirContents;
  readDirRecursive = dir:
    let
      dirContents = readDir dir;
      f = file: type:
        if type == "directory" then readDirRecursive "${dir}/${file}" else type;
    in mapAttrs f dirContents;
}
