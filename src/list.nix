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

  tailElems = list:
    genList (i: elemAt list (i + 1)) ((length list) - 1);

}
