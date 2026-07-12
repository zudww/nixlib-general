let

  sublibs = {
    strings = import ./strings.nix lib;
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
  };

  lib = toplevel // sublibs;
in
  lib
