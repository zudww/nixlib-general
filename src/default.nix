let

  sublibs = {
    strings = import ./strings.nix lib;
    types = import ./types.nix lib;
  };

  toplevel = {
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
