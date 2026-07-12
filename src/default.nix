let

  sublibs = {
    attrset = import ./attrset.nix lib;
    strings = import ./strings.nix lib;
    types = import ./types.nix lib;
  };

  toplevel = {
    inherit (sublibs.attrset)
      blacklistAttrs
      removeAttrPath
      filterAttrs
      keepAttrs
      remapAttrs
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
  };

  lib = toplevel // sublibs;
in
  lib
