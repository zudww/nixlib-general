# nixlib-general

A general-purpose utility library for Nix.

> ⚠️ **Work in progress.** History will be rewritten (force-pushes, rebases, squashes) until the first stable tag exists. There is no `main` branch yet. 

## Status

Currently implemented:

**Attrset**
- `remapAttrs` — remap name and value
- `filterAttrs` — filter attrs in by predicate
- `keepAttrs` — keep only selected attrs (errors if the attr doesn't exist)
- `whitelistAttrs` — accept only selected attrs (doesn't error)
- `blacklistAttrs` — opposite of `lib.whitelistAttrs`
- `removeAttrPath` — delete a deep path
- `invertAttrs` — swaps name and value of an attribute (uses `builtins.toString` for values)

**List**
- `headElem` — first element
- `tailElems` — all but the first
- `initElems` — all but the last
- `lastElem` — last element
- `sliceOfElems` — takes a slice out of a list
- `takeElems` — takes the first N elements
- `dropElems` — removes the first N elements
- `takeElemsUntil` — keeps elements until predicate is true
- `dropElemsUntil` — drops elements until predicate is true

**String**
- `strToChars` — splits a string into a list of characters
- `string.uppercaseFirstChar` — makes the first character uppercased
- `trimFloatStr` — trims trailing zeros from a float rendered as a string
- `escapeChars` — prefixes listed strings occurences with `"\\"`
- `escapeRegexChars` — escapes regex characters
- `toString` — turns any nix type into a string representation
- `toRepr` — turns any nix type into a string type representation
- `toUpperCase` — turns every alphabet character into uppercase

**Types**
- `typesOf` — transforms each attribute as a string of the type of the attribute had
- `isType` — checks if a value matches a given type (string)
- `withDefault` — returns a fallback if a value doesn't match an expected type

## License

See [LICENSE.md](./LICENSE.md).
