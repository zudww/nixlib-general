let

  sublibs = {
    strings = import ./strings.nix lib;
  };

  toplevel = {
    inherit (sublibs.strings)
      toString
      ;
  };

  lib = toplevel // sublibs;
in
  lib
