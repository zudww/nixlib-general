lib: let

  inherit (builtins)
    attrNames
    filter
    readDir;

in {

  listFiles = dir:
    let contents = readDir dir; in
    filter (v: v != null) (
      map
      (file: if contents.${file} != "regular" then null else dir + "/${file}")
      (attrNames contents)
    );

  listDirs = dir:
    let contents = readDir dir; in
    filter (v: v != null) (
      map
      (file: if contents.${file} != "directory" then null else dir + "/${file}")
      (attrNames contents)
    );

}
