lib: let

  inherit (builtins)
    attrNames
    elemAt
    filter
    foldl'
    isAttrs
    isBool
    isFloat
    isFunction
    isList
    isString
    length
    split
    stringLength
    substring
    ;

in {

  toRepr = v:
    if isString v then ''"${v}"'' else
    lib.toString v;

  toString = v: let
    evalSet = "{ ${foldl' (str: attr: str + attr + " = " + (lib.toRepr v.${attr}) + "; " ) "" (attrNames v)}}";
    evalList = let
      len = length v;
      loop = i: str:
        if i == len then str else
        loop (i + 1) (str + lib.toRepr (elemAt v i) + " ");
    in
      loop 0 "[ " + "]";
  in
    if isAttrs v then evalSet else
    if isList v then evalList else
    if isBool v then (if v then "true" else "false") else
    if isFunction v then "«lambda»" else
    if isFloat v then lib.strings.trimFloatStr (toString v) else
    if isNull v then "null" else
    toString v;

  trimFloatStr = str: let
    stripTrailingZerosLoop = i: let
      char = substring i 1 str;
    in
      if char == "0" then stripTrailingZerosLoop (i - 1) else
      if char != "." then substring 0 (i + 1) str else
      elemAt (filter isString (split "\\." str)) 0;
  in
    stripTrailingZerosLoop ((stringLength str) - 1);

}
