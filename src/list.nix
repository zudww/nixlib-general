lib: let

  inherit (builtins)
    elemAt
    ;

in {

  headElem = list: elemAt list 0;

}
