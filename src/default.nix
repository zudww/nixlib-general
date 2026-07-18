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
        lengthOfStr
        matchStrRegex
        matchStrRegexCGs
        replaceStrings
        replaceMultipleStrings
        splitLines
        splitStr
        strToChars
        toRepr
        toString
        toUpperCase
        ;

      inherit (types)
        isAttrset
        isAttrsetType
        isBool
        isDerivation
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
        filterList
        forEachElem
        genList
        headElem
        initElems
        joinStrings
        joinStringsSep
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
