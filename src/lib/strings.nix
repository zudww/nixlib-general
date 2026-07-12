lib: let

  inherit (builtins)
    elemAt
    filter
    isString
    split
    stringLength
    substring
    ;

in {

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
