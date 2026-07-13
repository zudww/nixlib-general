lib: let

  inherit (builtins)
    attrNames
    elemAt
    foldl'
    length
    ;

in {

  blacklistAttrs = attrset: blacklist:
    foldl' (acc: attr: if attrset ? ${attr} then removeAttrs acc [ attr ] else acc)
    attrset blacklist;

  filterAttrs = attrset: shouldKeep:
    foldl' (
      acc: attr:
        if shouldKeep attr attrset.${attr} then acc
        else removeAttrs acc [ attr ]
    )
    attrset (attrNames attrset);

  forEachAttr = initialState: attrset: foldlFn:
    builtins.foldl' (acc: attr: foldlFn acc attr attrset.${attr})
    initialState (builtins.attrNames attrset);

  genAttrs = listOfAttrs: getVal:
    builtins.foldl' (acc: attr: acc // { ${attr} = getVal attr; })
    {} listOfAttrs;

  invertAttrs = attrset:
    foldl' (acc: attr: acc // { ${toString attrset.${attr}} = attr; })
    {} (attrNames attrset);

  keepAttrs = attrset: keep:
    foldl' (acc: attr: acc // { ${attr} = attrset.${attr}; })
    {} keep;

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
