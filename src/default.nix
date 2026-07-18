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
        getFileExt
        getFileType
        isDir
        isFile
        isSymlink
        listFiles
        listDirs
        ;

      inherit (strings)
        charAt
        containsStr
        endsWithStr
        escapeChars
        escapeNixIdentifiers
        escapeRegexChars
        headChar
        lastChar
        lengthOfStr
        matchStrRegex
        matchStrRegexCGs
        repeatStr
        replaceStrings
        replaceMultipleStrings
        splitLines
        splitStr
        sliceOfChars
        startsWithStr
        strToChars
        tailStr
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
        allElems
        anyElems
        containsElem
        dropElems
        dropElemsUntil
        elemAt
        elemsAt
        filterList
        forEachElem
        genList
        headElem
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
