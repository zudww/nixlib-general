lib: let

  inherit (builtins)
    attrNames
    elemAt
    filter
    foldl'
    genList
    length
    listToAttrs
    ;

in {

  blacklistAttrs = removeAttrs;

  filterAttrs = attrset: shouldKeep:
    removeAttrs attrset (filter (attr: !(shouldKeep attr attrset.${attr})) (attrNames attrset));

  forEachAttr = initialState: attrset: foldlFn:
    builtins.foldl' (acc: attr: foldlFn acc attr attrset.${attr})
    initialState (builtins.attrNames attrset);

  genAttrs = listOfAttrs: getVal:
    listToAttrs (genList (i: rec {
      name = elemAt listOfAttrs i;
      value = getVal name;
    }) (length listOfAttrs));

  invertAttrs = attrset: let
    names = attrNames attrset;
  in
    listToAttrs (genList (i: rec {
      name = toString attrset.${value};
      value = elemAt names i;
    }) (length names));

  keepAttrs = attrset: keep:
    listToAttrs (genList (i: rec {
      name = elemAt keep i;
      value = attrset.${name};
    }) (length keep));

  remapAttrs = attrset: remapAttr:
    foldl' (
      acc: attr:
        let attr' = remapAttr attr attrset.${attr}; in
        acc // { ${attr'.name} = attr'.value; }
    )
    {} (attrNames attrset);

  removeAttrPath = attrset: path: let
    pathLength = length path;
    recurseInto = i: attrset': let
      attr = elemAt path (i - 1);
    in
      if i == pathLength then removeAttrs attrset' [ (elemAt path (pathLength - 1)) ]
      else attrset' // { ${attr} = recurseInto (i + 1) attrset'.${attr}; };
  in
    recurseInto 1 attrset;

  whitelistAttrs = attrset: whitelist:
    foldl' (acc: attr: if attrset ? ${attr} then acc // { ${attr} = attrset.${attr}; } else acc )
    {} whitelist;

}
