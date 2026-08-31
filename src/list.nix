lib: let

  inherit (builtins)
    all
    any
    attrNames
    elem
    elemAt
    filter
    foldl'
    genList
    head
    length
    tail
    ;

in {

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

  filterList = list: filterFn: filter filterFn list;

  forEachElem = initialState: elems: forEach:
    foldl' forEach initialState elems;

  genList = maxIndex: getIndex: genList getIndex maxIndex;

  headElem = head;

  lastElem = list: elemAt list ((length list) - 1);

  lengthOfList = length;

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
