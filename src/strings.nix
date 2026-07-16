lib: let

  inherit (builtins)
    attrNames
    concatStringsSep
    elemAt
    filter
    foldl'
    genList
    isAttrs
    isBool
    isFloat
    isFunction
    isList
    isString
    length
    replaceStrings
    split
    stringLength
    substring
    typeOf
    ;

in {

  escapeChars = list: replaceStrings list (map (c: "\\${c}") list);

  escapeRegexChars = lib.escapeChars (lib.strToChars "\\[{()^$?*+|.");

  joinStr = strings:
    concatStringsSep "" strings;

  joinStrSep = sep: strings:
    concatStringsSep sep strings;

  splitLines = str:
    filter (elem: typeOf elem == "string") (split "\n" str);

  splitStr = sep: str:
    filter (elem: typeOf elem == "string") (split (lib.escapeRegexChars sep) str);

  strToChars = str:
    genList (i: substring i 1 str) (stringLength str);

  toRepr = v:
    if isString v then ''"${v}"'' else
    lib.toString v;

  toString = v: let
    evalSet = "{ ${concatStringsSep "" (map (attr: "${attr} = ${lib.toRepr v.${attr}}; ") (attrNames v))}}";
    evalList = "[ ${concatStringsSep " " (map (elem: lib.toRepr elem) v)} ]";
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
      elemAt (filter isString (split "\\." str)) 0;
  in
    stripTrailingZerosLoop ((stringLength str) - 1);

  uppercaseFirstChar = str:
    lib.toUpperCase (substring 0 1 str) + substring 1 (-1) str;

}
