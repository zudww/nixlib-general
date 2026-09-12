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
        listFilesRecursive
        listDirs
        pathExists
        ;

      inherit (strings)
        charAt
        containsStr
        endsWithStr
        escapeChars
        escapeNixIdentifiers
        escapeRegexChars
        headChar
        joinStrings
        joinStringsSep
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
        isAttrs
        isAttrset
        isAttrsetType
        isBool
        isDerivation
        isFloat
        isFunction
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
        accForEachElem
        allElems
        anyElems
        attrsToList
        containsElem
        dropElems
        dropElemsUntil
        elemAt
        genList
        headElem
        indexOfMatch
        indicesOfMatch
        insertAfterElemAt
        insertAfterElemsAt
        insertBeforeElemAt
        insertBeforeElemsAt
        joinLists
        keepElemsIf
        lastElem
        lengthOfList
        listToAttrs
        remapElems
        removeElemAt
        removeElemsAt
        replaceElemAt
        replaceElemsAt
        sliceOfElems
        tailElems
        takeElems
        takeElemsUntil
        ;
    };
  in
    lib;
}
