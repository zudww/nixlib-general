let

  sublibs = {
    strings = import ./strings.nix lib;
  };

  toplevel = {
    inherit (sublibs.strings)
      strToChars
      toRepr
      toString
      toUpperCase
      ;
  };

  lib = toplevel // sublibs;
in
  lib
