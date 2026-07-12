let

  sublibs = {
    strings = import ./strings.nix lib;
  };

  toplevel = {};

  lib = toplevel // sublibs;
in
  lib
