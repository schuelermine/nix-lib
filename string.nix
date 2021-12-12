{ lib }: rec {
  chars = str:
    builtins.concatLists
    (map (x: if builtins.isList x then x else if x == "" then [ ] else [ x ])
      (builtins.split "" str));
  concatStrings = strs: builtins.foldl' (x: y: x + y) "" strs;
  escapeRegexChar = ch:
    if builtins.elem ch [
      "["
      "]"
      "."
      "\\"
      "("
      ")"
      "+"
      "*"
      "?"
      "<"
      ">"
      ":"
      "-"
      "$"
      "^"
      "|"
    ] then
      "\\" + ch
    else
      ch;
  escapeRegex = str: concatStrings (map escapeRegexChar (chars str));
}
