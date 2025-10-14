{
  pkgs,
  lib,
  dotFiles,
  ...
}: {
# NOTE: there is no `programs.ghostty` option in official Home Manager for M1
# Mac.
  programs.ghostty = {
    enable = true;
    package = null; # since Ghostty is installed outside Nix Programs (home.package)
    enableBashIntegration = true;
    enableZshIntegration = true;
    # installVimSyntax = true;
    settings = {
      # theme = "Dracula";
      keybind = [
        # "ctrl+comma=open_config"
      ];
      font-size = lib.mkForce 17;
      font-family = "GoMono Nerd Font";
      window-decoration = false;
      fullscreen = true;
      macos-non-native-fullscreen = "visible-menu";
      confirm-close-surface = false;
      mouse-hide-while-typing = true;

      window-padding-x = 5;
      window-padding-y = 5;

      window-theme = "dark";

      # Disables ligatures
      font-feature = ["-liga" "-dlig" "-calt"];

      custom-shader = "~/.config/ghostty/shaders/cursor-blade-no-trail.glsl";
    };
  };

  home.file."/Applications/Ghostty.app".source =
  "${pkgs.ghostty-bin}/Applications/Ghostty.app";

  # Link the shaders folder
  home.file.".config/ghostty/shaders".source = "${dotFiles}/ghostty/shaders";
}
