{ lib, ... }:
with builtins;
with lib; {
  concatStrings = foldl' (c1: c2: c1 + c2) "";
  filterSplitSegments = str:
    concatLists
    (map (x: if isList x then x else if x == "" then [ ] else [ x ]) str);
  splitToChars = str: filterSplitSegments (split "" str);
  asChars = f: str: concatStrings (f (splitToChars str));
  capitalize = asChars (asHead toUpper);
}
