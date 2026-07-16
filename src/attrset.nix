lib: let

  inherit (builtins)
    attrNames
    elem
    elemAt
    filter
    foldl'
    genList
    head
    isAttrs
    length
    listToAttrs
    tail
    ;

in {

  blacklistAttrs = removeAttrs;

  filterAttrs = attrset: shouldKeep:
    removeAttrs attrset (filter (attr: !(shouldKeep attr attrset.${attr})) (attrNames attrset));

  forEachAttr = initialState: attrset: foldlFn:
    foldl' (acc: attr: foldlFn acc attr attrset.${attr})
    initialState (attrNames attrset);

  genAttrs = listOfAttrs: getVal:
    listToAttrs (genList (i:
      let name = elemAt listOfAttrs i; in
      { name = name; value = getVal name; }
    ) (length listOfAttrs));

  invertAttrs = attrset: let
    names = attrNames attrset;
  in
    listToAttrs (genList (i:
      let name = elemAt names i; in
      { name = toString attrset.${name}; value = name; }
    ) (length names));

  keepAttrs = attrset: keep:
    listToAttrs (genList (i:
      let name = elemAt keep i; in
      { name = name; value = attrset.${name}; }
    ) (length keep));

  remapAttrs = attrset: remapAttr: let
    names = attrNames attrset;
  in
    listToAttrs (genList (i:
      let name = elemAt names i; in
      remapAttr name (attrset.${name})
    ) (length names));

  removeAttrPath = attrset: path: let
    pathHead = head path;
    pathTail = tail path;
  in
    if path == [] || !(isAttrs attrset) then attrset else
    if pathTail == [] then removeAttrs attrset [ pathHead ] else
    if attrset ? ${pathHead} then attrset // { ${pathHead} = lib.removeAttrPath attrset.${pathHead} pathTail; }
    else attrset;

  whitelistAttrs = attrset: whitelist:
    removeAttrs attrset (filter (v: !(elem v whitelist)) (attrNames attrset));

}
