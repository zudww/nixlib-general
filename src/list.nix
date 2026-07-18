lib: let

  inherit (builtins)
    elemAt
    filter
    genList
    length
    foldl'
    ;

in {

  inherit (builtins)
    listToAttrs
    ;

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

  headElem = list: elemAt list 0;

  initElems = list:
    let len = length list; in
    if len == 0 then [] else
    genList (elemAt list) (len - 1);

  lastElem = list: elemAt list ((length list) - 1);

  lengthOfList = length;

  sliceOfElems = i1: i2: list: let
    len = length list;
    start = if i1 < 0 then 0 else if i1 > len then len else i1;
    stop = if i2 >= len then len - 1 else i2;
    count = if stop < start then 0 else stop - start + 1;
  in
    genList (i: elemAt list (i + start)) count;

  tailElems = list:
    let len = length list; in
    if len == 0 then [] else
    genList (i: elemAt list (i + 1)) (len - 1);

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
