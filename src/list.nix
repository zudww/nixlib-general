lib: let

  inherit (builtins)
    elemAt
    genList
    length
    ;

in {

  dropElems = n: list: let
    len = length list;
    start = if n < 0 then 0 else if n > len then len else n;
  in
    genList (i: elemAt list (i + start)) (len - start);

  headElem = list: elemAt list 0;

  initElems = list:
    let len = length list; in
    if len == 0 then [] else
    genList (elemAt list) (len - 1);

  lastElem = list: elemAt list ((length list) - 1);

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

}
