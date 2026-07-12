lib: let

  inherit (builtins)
    attrNames
    foldl'
    ;

in {

  filterAttrs = attrset: shouldKeep:
    foldl' (
      acc: attr:
        if shouldKeep attr attrset.${attr} then acc
        else removeAttrs acc [ attr ]
    )
    attrset (attrNames attrset);

  remapAttrs = attrset: remapAttr:
    foldl' (
      acc: attr:
        let attr' = remapAttr attr attrset.${attr}; in
        acc // { ${attr'.name} = attr'.value; }
    )
    {} (attrNames attrset);

}
