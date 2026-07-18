lib: let

  inherit (builtins)
    mapAttrs
    typeOf
    ;

in {

  inherit (builtins)
    typeOf
    ;

  isType = type: val: (typeOf val) == type;

  typesOf = attrs: mapAttrs (_: val: typeOf val) attrs;

  withDefault = type: default: val: if typeOf val != type then default else val;

}
