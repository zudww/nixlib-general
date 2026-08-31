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
- `whitelistAttrs` — accept only selected attrs (doesn't error)
- `blacklistAttrs` — opposite of `lib.whitelistAttrs`
- `removeAttrPath` — delete a deep path
- `invertAttrs` — swaps name and value of an attribute (uses `builtins.toString` for values)
- `updateAttrs` — shallow merge of two attrsets (`a // b`)
- `updateAttrsRecursive` — recursively merges two attrsets, going deeper wherever both sides have a set at the same key

**List**
- `forEachElem` — remap `builtins.foldl'`
- `headElem` — first element
- `tailElems` — all but the first
- `lastElem` — last element
- `sliceOfElems` — takes a slice out of a list
- `takeElems` — takes the first N elements
- `dropElems` — removes the first N elements
- `takeElemsUntil` — keeps elements until predicate is true
- `dropElemsUntil` — drops elements until predicate is true
- `filterList` — filter a list by predicate
- `joinStrings` — concatenates a list of strings
- `joinStringsSep` — concatenates a list of strings with a separator

**String**
- `strToChars` — splits a string into a list of characters
- `splitStr` — splits a string by delimiter
- `splitLines` — splits a string by newlines
- `uppercaseFirstChar` — makes the first character uppercased
- `trimFloatStr` — trims trailing zeros from a float rendered as a string
- `escapeChars` — prefixes listed strings occurences with `"\\"`
- `escapeRegexChars` — escapes regex characters
- `escapeNixIdentifiers` — escapes a string so it's safe to use as a Nix identifier/attr name
- `toString` — turns any nix type into a string representation
- `toRepr` — turns any nix type into a string type representation
- `toUpperCase` — turns every alphabet character into uppercase
- `repeatStr` — repeats a string N times
- `replaceStrings` — replaces one string with another (single-pair version of `builtins.replaceStrings`)
- `replaceMultipleStrings` — alias for `builtins.replaceStrings` (list-of-pairs version)
- `containsStr` / `startsWithStr` / `endsWithStr` — substring, prefix, and suffix checks
- `matchStrRegex` — whether a string matches a regex, as a bool
- `matchStrRegexCGs` — alias for `builtins.match` (returns capture groups)

**Types**
- `typesOf` — transforms each attribute as a string of the type of the attribute had
- `isType` — checks if a value matches a given type (string)
- `withDefault` — returns a fallback if a value doesn't match an expected type
- `isAttrset` — alias for `builtins.isAttrs`
- `isAttrsetType` — checks whether an attrset has a `type` field matching the given type
- `isDerivation` — checks whether a value looks like a derivation (`drv ? drvPath`)
- `isLambda` — alias for `builtins.isFunction`

**Filesystem**
- `getFileExt` — extracts a path's file extension
- `getFileType` — alias for `builtins.readFileType`
- `isDir` / `isFile` / `isSymlink` — checks a path's file type
- `listFiles` — lists regular files in a directory
- `listFilesRecursive` — recursively lists regular files under a directory
- `listDirs` — lists subdirectories of a directory

## License

See [LICENSE](./LICENSE).
