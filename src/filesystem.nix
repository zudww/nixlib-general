lib: let

  inherit (builtins)
    attrNames
    elemAt
    filter
    match
    readDir
    readFileType
    ;

in {

  getFileExt = path:
    let search = match "^..*\\.\(.*\)$" (baseNameOf path); in
    if search == null then "" else elemAt search 0;

  getFileType = readFileType;

  isDir = path: readFileType path == "directory";

  isFile = path: readFileType path == "regular";

  isSymlink = path: readFileType path == "symlink";

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
