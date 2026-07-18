lib: let

  inherit (builtins)
    isAttrs
    isFunction
    mapAttrs
    typeOf
    ;

in {

  inherit (builtins)
    typeOf
    isBool
    isFloat
    isInt
    isList
    isNull
    isPath
    isString
    ;

  isAttrset = isAttrs;

  isAttrsetType = type: attrset: attrset ? type && attrset.type == type;

  isDerivation = drv: drv ? drvPath;

  isLambda = isFunction;

  isType = type: val: (typeOf val) == type;

  typesOf = attrs: mapAttrs (_: val: typeOf val) attrs;

  withDefault = type: default: val: if typeOf val != type then default else val;

}
