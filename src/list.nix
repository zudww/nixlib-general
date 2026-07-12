lib: let

  inherit (builtins)
    elemAt
    genList
    length
    ;

in {

  headElem = list: elemAt list 0;

  tailElems = list:
    genList (i: elemAt list (i + 1)) ((length list) - 1);

}
