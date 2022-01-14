{ self }: rec {
  chars = str:
    builtins.concatLists
    (map (x: if builtins.isList x then x else if x == "" then [ ] else [ x ])
      (builtins.split "" str));
  concat = builtins.foldl' (x: y: x + y) "";
  escapeRegexChar = char:
    if builtins.elem char [
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
      "\\" + char
    else
      char;
  escapeRegex = str: concatStrings (map escapeRegexChar (chars str));
  isChar = str: builtins.stringLength str == 1;
}
