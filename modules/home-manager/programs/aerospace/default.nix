{
  lib,
  pkgs,
  dotFiles,
  ...
}:
{
  config = lib.mkIf (pkgs.stdenv.isDarwin) {
    # Ensure aerospace package installed
    home.packages = [ pkgs.aerospace ];

    # Map dotfile
    home.file.".config/aerospace.toml".source = "${dotFiles}/aerospace/aerospace.toml";
  }
}
