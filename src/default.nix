_: {

  lib = let

    attrset = import ./attrset.nix lib;
    filesystem = import ./filesystem.nix lib;
    strings = import ./strings.nix lib;
    types = import ./types.nix lib;
    list = import ./list.nix lib;

    lib = {

      inherit
        attrset
        filesystem
        strings
        types
        list
        ;

      inherit (attrset)
        attrNames
        attrValues
        blacklistAttrs
        filterAttrs
        forEachAttr
        genAttrs
        invertAttrs
        keepAttrs
        remapAttrs
        removeAttrPath
        updateAttrs
        updateAttrsRecursive
        whitelistAttrs
        ;

      inherit (filesystem)
        listFiles
        listDirs
        ;

      inherit (strings)
        escapeChars
        escapeNixIdentifiers
        escapeRegexChars
        joinStr
        joinStrSep
        splitLines
        splitStr
        strToChars
        toRepr
        toString
        toUpperCase
        ;

      inherit (types)
        isAttrset
        isBool
        isFloat
        isInt
        isLambda
        isList
        isNull
        isPath
        isString
        isType
        typeOf
        typesOf
        withDefault
        ;

      inherit (list)
        dropElems
        dropElemsUntil
        elemAt
        forEachElem
        genList
        headElem
        initElems
        lastElem
        lengthOfList
        listToAttrs
        sliceOfElems
        tailElems
        takeElems
        takeElemsUntil
        ;
    };
  in
    lib;
}
