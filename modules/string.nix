{ lib, nixpkgsLib, ... }:
with builtins;
with lib; {
  concatStrings = foldl' (c1: c2: c1 + c2) "";
  filterSplitSegments = str:
    concatLists
    (map (x: if isList x then x else if x == "" then [ ] else [ x ]) str);
  splitToChars = str: filterSplitSegments (split "" str);
  asChars = f: str: concatStrings (f (splitToChars str));
  capitalize = asChars (asHead nixpkgsLib.toUpper);
  splitToWords = str: filterSplitSegments (split " " str);
  asWords = f: str: concatStringsSep " " (f (splitToWords str));
  snakeCase = str:
    concatStringsSep "" (asTail (map capitalize) (splitToWords str));
}
