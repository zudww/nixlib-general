lib: let

  inherit (builtins)
    attrNames
    concatStringsSep
    elemAt
    genList
    isAttrs
    isBool
    isFloat
    isFunction
    isList
    isString
    length
    match
    replaceStrings
    split
    stringLength
    substring
    ;

in {

  escapeChars = list: replaceStrings list (map (c: "\\${c}") list);

  escapeNixIdentifiers = s: let
    nixKeywords = {
      "assert" = true;
      "else" = true;
      "if" = true;
      "in" = true;
      "inherit" = true;
      "let" = true;
      "or" = true;
      "rec" = true;
      "then" = true;
      "with" = true;
    };
  in
    if (match "[a-zA-Z_][a-zA-Z0-9_'-]*" s != null) && !(nixKeywords ? ${s}) then s else
    lib.escapeChars [ "$" ] (builtins.toJSON s);

  escapeRegexChars = lib.escapeChars (lib.strToChars "\\[{()^$?*+|.");

  matchStrRegex = regex: string: (match regex string) != null;

  matchStrRegexCGs = match;

  replaceStrings = from: to: replaceStrings [from] [to];

  replaceMultipleStrings = replaceStrings;

  splitLines = lib.splitStr "\n";

  splitStr = sep: str:
    let splitStr = split (lib.escapeRegexChars sep) str; in
    genList (i: elemAt splitStr (i * 2)) ((length splitStr / 2) + 1);

  splitStrRegexCGs = split;

  strToChars = str:
    genList (i: substring i 1 str) (stringLength str);

  toRepr = v:
    if isString v then ''"${v}"'' else
    lib.toString v;

  toString = v: let
    evalSet = "{ ${concatStringsSep "" (map (attr: "${lib.escapeNixIdentifiers attr} = ${lib.toRepr v.${attr}}; ") (attrNames v))}}";
    evalList = "[ ${concatStringsSep " " (map (elem: lib.toRepr elem) v)}]";
  in
    if isAttrs v then evalSet else
    if isList v then evalList else
    if isBool v then (if v then "true" else "false") else
    if isFunction v then "«lambda»" else
    if isFloat v then lib.strings.trimFloatStr (toString v) else
    if isNull v then "null" else
    toString v;

  toUpperCase = str: let
    lowerChars = lib.strToChars "abcdefghijklmnopqrstuvwxyz";
    upperChars = lib.strToChars "ABCDEFGHIJKLMNOPQRSTUVWXYZ";
  in
    replaceStrings lowerChars upperChars str;

  trimFloatStr = str: let
    stripTrailingZerosLoop = i: let
      char = substring i 1 str;
    in
      if char == "0" then stripTrailingZerosLoop (i - 1) else
      if char != "." then substring 0 (i + 1) str else
      elemAt (split "\\." str) 0;
  in
    stripTrailingZerosLoop ((stringLength str) - 1);

  uppercaseFirstChar = str:
    lib.toUpperCase (substring 0 1 str) + substring 1 (-1) str;

}
