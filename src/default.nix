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
      forEachAttr
      genAttrs
      invertAttrs
      keepAttrs
      remapAttrs
      removeAttrPath
      updateAttrs
      updateAttrsRecursive
      whitelistAttrs
      ;

    inherit (sublibs.strings)
      escapeChars
      escapeNixIdentifiers
      escapeRegexChars
      joinStr
      joinStrSep
      splitLines
      splitStr
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
      dropElems
      dropElemsUntil
      forEachElem
      headElem
      initElems
      lastElem
      sliceOfElems
      tailElems
      takeElems
      takeElemsUntil
      ;
  };

  lib = toplevel // sublibs;
in
  lib
