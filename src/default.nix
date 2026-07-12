let

  sublibs = {
    attrset = import ./attrset.nix lib;
    strings = import ./strings.nix lib;
    types = import ./types.nix lib;
    list = import ./list.nix lib;
  };

  toplevel = {
    inherit (sublibs.attrset)
      blacklistAttrs
      filterAttrs
      invertAttrs
      keepAttrs
      remapAttrs
      removeAttrPath
      whitelistAttrs
      ;

    inherit (sublibs.strings)
      escapeChars
      escapeRegexChars
      strToChars
      toRepr
      toString
      toUpperCase
      ;

    inherit (sublibs.types)
      isType
      typesOf
      withDefault
      ;

    inherit (sublibs.list)
      headElem
      initElems
      lastElem
      tailElems
      ;
  };

  lib = toplevel // sublibs;
in
  lib
