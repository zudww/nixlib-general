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

}
