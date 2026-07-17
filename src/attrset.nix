lib: let

  inherit (builtins)
    attrNames
    filter
    foldl'
    head
    isAttrs
    listToAttrs
    tail
    typeOf
    ;

in {

  blacklistAttrs = removeAttrs;

  filterAttrs = attrset: shouldKeep:
    removeAttrs attrset (filter (attr: !(shouldKeep attr attrset.${attr})) (attrNames attrset));

  forEachAttr = initialState: attrset: foldlFn:
    foldl' (acc: attr: foldlFn acc attr attrset.${attr})
    initialState (attrNames attrset);

  genAttrs = listOfAttrs: getVal:
    listToAttrs (map (name: { name = name; value = getVal name; }) listOfAttrs);

  # priority is last to first (first overrides last) alphabetically
  invertAttrs = attrset:
    listToAttrs (map (name: { name = toString attrset.${name}; value = name; }) (attrNames attrset));

  keepAttrs = attrset: keep:
    listToAttrs (map (name: { name = name; value = attrset.${name}; }) keep);

  # priority is last to first (first overrides last) alphabetically
  remapAttrs = attrset: remapAttr:
    listToAttrs (map (name: remapAttr name attrset.${name}) (attrNames attrset));

  removeAttrPath = attrset: path: let
    pathHead = head path;
    pathTail = tail path;
  in
    if path == [] || !(isAttrs attrset) then attrset else
    if pathTail == [] then removeAttrs attrset [ pathHead ] else
    if attrset ? ${pathHead} then attrset // { ${pathHead} = lib.removeAttrPath attrset.${pathHead} pathTail; }
    else attrset;

  updateAttrs = a: b: a // b;

  updateAttrsRecursive = a: b: let
    updatedAttrs = listToAttrs (map
      (name: {
        name = name;
        value = let
          aAttr = a.${name};
          bAttr = b.${name};
        in
          if (typeOf bAttr == "set") && a ? ${name} && (typeOf aAttr == "set")
          then lib.updateAttrsRecursive aAttr bAttr
          else bAttr;
      })
      (attrNames b)
    );
  in
    a // updatedAttrs;

  whitelistAttrs = attrset: whitelist: listToAttrs (map
    (name: { name = name; value = attrset.${name}; })
    (filter (name: attrset ? ${name}) whitelist)
  );

}
