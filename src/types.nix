lib: let

  inherit (builtins)
    mapAttrs
    typeOf
    ;

in {

  typesOf = attrs: mapAttrs (_: val: typeOf val) attrs;

}
