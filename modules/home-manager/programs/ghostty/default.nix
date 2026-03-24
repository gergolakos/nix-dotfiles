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
    package = if pkgs.stdenv.isDarwin then pkgs.ghostty-bin else pkgs.ghostty;
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

  # NOTE: Symlinking Ghostty.app does not work on macOS: Spotlight ignores
  # symlinks so the app won't appear in search

  # home.file."/Applications/Ghostty.app".source =
  # "${pkgs.ghostty-bin}/Applications/Ghostty.app";

  # NOTE: This activation script is imperative, not idempotent. It copies
  # Ghostty.app into ~/Applications (outside the Nix store), which home-manager
  # cannot track or garbage-collect. Consequences:
  #   - Removing this module will NOT delete ~/Applications/Ghostty.app
  # home.activation.installGhostty = lib.hm.dag.entryAfter ["writeBoundary"] ''
  #   GHOSTTY_SRC="${pkgs.ghostty-bin}/Applications/Ghostty.app"
  #   GHOSTTY_DST="$HOME/Applications/Ghostty.app"
  #
  #   # Only copy if source is newer or destination doesn't exist
  #   if [ ! -d "$GHOSTTY_DST" ] || [ "$GHOSTTY_SRC" -nt "$GHOSTTY_DST" ]; then
  #     $DRY_RUN_CMD rm -rf "$GHOSTTY_DST"
  #     $DRY_RUN_CMD cp -rL "$GHOSTTY_SRC" "$GHOSTTY_DST"
  #   fi
  # '';

  # Link the shaders folder
  home.file.".config/ghostty/shaders".source = "${dotFiles}/ghostty/shaders";
}
