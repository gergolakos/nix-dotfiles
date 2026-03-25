{
  lib,
  pkgs,
  dotFiles,
  ...
}:
{
  programs.aerospace = {
    enabled = false;
  };

  # Map dotfile
  home.file.".config/aerospace.toml".source = "${dotFiles}/aerospace/aerospace.toml";
}
