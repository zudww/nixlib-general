lib: let

  inherit (builtins)
    attrNames
    filter
    readDir;

in {

  listDirs = dir:
    let contents = readDir dir; in
    filter (v: v != null) (
      map
      (file: if contents.${file} != "directory" then null else dir + "/${file}")
      (attrNames contents)
    );

}
