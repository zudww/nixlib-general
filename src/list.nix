lib: let

  inherit (builtins)
    elemAt
    genList
    length
    ;

in {

  headElem = list: elemAt list 0;

  initElems = list:
    genList (i: elemAt list i) ((length list) - 1);

  lastElem = list: elemAt list ((length list) - 1);

  sliceOfElems = i1: i2: list:
    genList (i: elemAt list (i + i1)) (1 + i2 - i1);

  tailElems = list:
    genList (i: elemAt list (i + 1)) ((length list) - 1);

}
