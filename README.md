# nixlib-general

A general-purpose utility library for Nix.

## Status

Currently implemented:

**Attrset**
- `remapAttrs` — remap name and value
- `genAttrs` — generates values from a list of attr names
- `getAttrNames` — returns a list of the names of an attrset
- `forEachAttr` — `builtins.foldl'` but loops through attribute names and value
- `filterAttrs` — filter attrs in by predicate
- `keepAttrs` — keep only selected attrs (errors if the attr doesn't exist)
- `whitelistAttrs` — accept only selected attrs
- `blacklistAttrs` — opposite of `lib.whitelistAttrs`
- `removeAttrPath` — delete a deep attribute using a path
- `invertAttrs` — swaps name and value of an attribute (uses `builtins.toString` for values to convert to names)
- `updateAttrs` — shallow merge of two attrsets (`a // b`)
- `updateAttrsRecursive` — recursively merges two attrsets, going deeper wherever both sides have a set (lists not recursed)

**List**
- `accForEachElem` — process a list from left to right, combining its elements into a single result. (foldl)
- `attrsToList` — turns an attrset to a list using a function for each element that takes in the name and value of the attrset.
- `headElem` — first element
- `tailElems` — all but the first
- `lastElem` — last element
- `sliceOfElems` — takes a slice out of a list
- `takeElems` — takes the first N elements
- `dropElems` — removes the first N elements
- `takeElemsUntil` — keeps elements until predicate is true
- `dropElemsUntil` — removes elements until predicate is true
- `keepElemsIf` — filter a list by predicate
- `joinLists` — concatenates a list of lists
- `remapElems` — remaps each value in a list.
- `lengthOfList` — returns how much elements are in a list.
- `elemAt` — returns the element at a specific index (starting from 0) in a list.

- `indexOfMatch` — returns the first matched elem, returning `null` if it none matched.

**String**
- `containsStr` / `startsWithStr` / `endsWithStr` — substring, prefix, and suffix checks
- `escapeChars` — prefixes occurrences of any of the listed strings with "\\"
- `escapeNixIdentifiers` — escapes any occurrences of Nix identifiers (mostly used for codegen)
- `escapeRegexChars` — escapes regex characters
- `matchStrRegex` — whether a string matches a regex
- `matchStrRegexCGs` — whether a string matches a regex, returning capture groups. alias of `builtins.match`
- `headChar` — gets the first character in a string
- `joinStrings` — concatenates a list of strings
- `joinStringsSep` — concatenates a list of strings with a separator
- `repeatStr` — repeats a string N times
- `replaceStrings` — replaces occurrences of a string with another string
- `replaceMultipleStrings` — alias of `builtins.replaceStrings`
- `strToChars` — turns a string into a list of characters
- `splitStr` — splits a string by delimiter
- `splitLines` — splits a string by newlines
- `trimFloatStr` — trims trailing zeros from a string representation of a float
- `toString` — turns any nix type into a string
- `toRepr` — turns any nix type into a string representation (`lib.toString` but just puts double quotes in strings)
- `toUpperCase` — turns every lowercased alphabet character into uppercase
- `uppercaseFirstChar` — makes the first character uppercased

**Types**
- `typeOf` / `isAttrs` / `isBool` / `isFloat` / `isFunction` / `isInt` / `isList` / `isNull` / `isPath` / `isString` — aliases from `builtins`
- `isAttrset` — alias of `builtins.isAttrs`
- `isDerivation` — checks whether a value looks like a derivation (should not be used as an absolute check)
- `isLambda` — alias of `builtins.isFunction`
- `isType` — checks if a value matches a given type (given type is in a string form)
- `typesOf` — remaps each attribute as a string of the type the attribute had
- `withDefault` — returns a fallback value if a value doesn't match an expected type

**Filesystem**
- `isDir` / `isFile` / `isSymlink` — checks a path's file type
- `getFileExt` — extracts a path's file extension
- `getFileType` — alias of `builtins.readFileType`
- `listDirs` — lists subdirectories of a directory
- `listFiles` — lists regular files in a directory
- `listFilesRecursive` — recursively lists regular files under a directory

## License

See [LICENSE](./LICENSE).
