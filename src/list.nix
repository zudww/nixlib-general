lib:
let

  inherit (builtins)
    all
    any
    attrNames
    concatLists
    elem
    elemAt
    filter
    foldl'
    genList
    head
    length
    tail
    ;

in
{
  accForEachElem = elems: initialState: forEachFn:
    foldl' forEachFn initialState elems;

  inherit (builtins)
    listToAttrs
    ;

  allElems = all;

  anyElems = any;

  attrsToList = attrs: getElem:
    map (name: getElem name (attrs.${name})) (attrNames attrs);

  containsElem = elem;

  dropElems = n: list: let
    len = length list;
    start = if n < 0 then 0 else if n > len then len else n;
  in
    genList (i: elemAt list (i + start)) (len - start);

  dropElemsUntil = list: predicate: let
    len = length list;
    mkList = startI: genList (i: elemAt list (startI + i)) (len - startI);
    loop = i:
      let v = elemAt list i; in
      if i > (len - 1) then []
      else if predicate v then mkList i
      else loop (i + 1);
  in
    loop 0;

  elemAt = index: list: elemAt list index;

  genList = maxIndex: getIndex: genList getIndex maxIndex;

  headElem = head;

  indicesOfMatch = list: matcher: let
    l = length list;
    iterator = i: acc:
      let v = elemAt list i; in
      if i == l then acc else
      iterator (i + 1) (if matcher v then acc ++ [ i ] else acc);
  in
    iterator 0 [];

  indexOfMatch = list: matcher: let
    l = length list;
    iterator = i:
      let v = elemAt list i; in
      if i == l then null else
      if matcher v then i else
      iterator (i + 1);
  in
    iterator 0;

  joinLists = concatLists;

  keepElemsIf = filter;

  lastElem = list: elemAt list ((length list) - 1);

  lengthOfList = length;

  remapElems = list: remapFn: map remapFn list;

  sliceOfElems = start: end: list: let
    len = length list;
    end' =
      let lms = len - start; in
      if end > lms || end < 0 then lms else
      end;
  in
    if start > (len - 1) then [] else
    genList (i: elemAt list (i + start)) end';

  tailElems = tail;

  takeElems = n: list: let
    len = length list;
    count = if n < 0 then 0 else if n > len then len else n;
  in
    genList (elemAt list) count;

  takeElemsUntil = list: predicate: let
    len = length list;
    mkList = endI: genList (i: elemAt list i) endI;
    loop = i:
      let v = elemAt list i; in
      if i > (len - 1) then list else
      if predicate v then mkList i else
      loop (i + 1);
  in
    loop 0;

}
