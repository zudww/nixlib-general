lib: let

  inherit (builtins)
    any
    attrNames
    isAttrs
    isFunction
    isString
    mapAttrs
    typeOf
    ;

in {

  inherit (builtins)
    typeOf
    isAttrs
    isBool
    isFloat
    isFunction
    isInt
    isList
    isNull
    isPath
    isString
    ;

  isAttrset = isAttrs;

  isAttrsetType = type: attrset: attrset ? type && attrset.type == type;

  isDerivation = drv: let
    drvPath = drv.drvPath or drv;
    ctx = builtins.getContext drvPath;
  in
    isString drvPath
    && any (n: lib.endsWithStr ".drv" n) (attrNames ctx);

  isLambda = isFunction;

  isType = type: val: (typeOf val) == type;

  typesOf = attrs: mapAttrs (_: val: typeOf val) attrs;

  withDefault = type: default: val: if typeOf val != type then default else val;

}
