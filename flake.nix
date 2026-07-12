{
  description = "actually general-purpose nix library";

  outputs = _: {
    lib = import ./src;
  };
}
