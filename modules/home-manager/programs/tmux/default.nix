{
  lib,
  pkgs,
  dotFiles,
  ...
}:
{
  programs.tmux = {
    enable = true;
  };
  # Map dotfile
  home.file.".tmux.conf".source = "${dotFiles}/tmux/tmux.conf";

}
