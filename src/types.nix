lib: let

  inherit (builtins)
    mapAttrs
    typeOf
    ;

in {

  isType = type: val: (typeOf val) == type;

  typesOf = attrs: mapAttrs (_: val: typeOf val) attrs;

}
