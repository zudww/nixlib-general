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
    sort
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

  indexOfMatch = list: matcher: let
    l = length list;
    iterator = i:
      let v = elemAt list i; in
      if i == l then null else
      if matcher v then i else
      iterator (i + 1);
  in
    iterator 0;

  indicesOfMatch = list: matcher: let
    l = length list;
    iterator = i: acc:
      let v = elemAt list i; in
      if i == l then acc else
      iterator (i + 1) (if matcher v then acc ++ [ i ] else acc);
  in
    iterator 0 [];

  insertAfterElemAt = index: list: elem:
    genList (i:
      if i <= index then elemAt list i else
      if i == (index + 1) then elem else
      elemAt list (i - 1)
    )
    ((length list) + 1);

  insertAfterElemsAt = indices: list: elem:
    (foldl' (acc: i: { acc = lib.insertAfterElemAt (i + acc.offs) acc.acc elem; offs = (acc.offs + 1); })
    { acc = list; offs = 0; } (sort (x: y: x < y) indices)).acc;

  insertBeforeElemAt = index: list: elem:
    genList (i:
      if i < index then elemAt list i else
      if i == index then elem else
      elemAt list (i - 1)
    )
    ((length list) + 1);

  insertBeforeElemsAt = indices: list: elem:
    (foldl' (acc: i: { acc = lib.insertBeforeElemAt (i + acc.offs) acc.acc elem; offs = (acc.offs + 1); })
    { acc = list; offs = 0; } (sort (x: y: x < y) indices)).acc;

  joinLists = concatLists;

  keepElemsIf = filter;

  lastElem = list: elemAt list ((length list) - 1);

  lengthOfList = length;

  remapElems = list: remapFn: map remapFn list;

  removeElemAt = index: list:
    genList (i: elemAt list (if i >= index then i + 1 else i))
    ((length list) - 1);

  removeElemsAt = indices: list:
    (foldl' (acc: i: { acc = lib.removeElemAt (i + acc.offs) acc.acc; offs = (acc.offs - 1); })
    { acc = list; offs = 0; } (sort (x: y: x < y) indices)).acc;

  replaceElemAt = index: list: value:
    genList (i: if i == index then value else elemAt list i)
    (length list);

  replaceElemsAt = indices: list: value:
    genList (i: if elem i indices then value else elemAt list i)
    (length list);

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
