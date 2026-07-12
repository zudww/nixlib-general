let

  sublibs = {
    strings = import ./strings.nix lib;
  };

  toplevel = {
    inherit (sublibs.strings)
      toRepr
      toString
      ;
  };

  lib = toplevel // sublibs;
in
  lib
