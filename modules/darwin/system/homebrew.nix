{
  config,
  lib,
  pkgs,
  isCorporate,
  ...
}:
{
  options = {
    my.homebrew.enable = lib.mkEnableOption "Enable custom Homebrew configuration";
  };
  config = lib.mkIf config.my.homebrew.enable {
    homebrew = {
      enable = true;
      onActivation = {
        autoUpdate = true;
        # cleanup = "none";
        cleanup = "zap"; # remove everything including casks not in config
        upgrade = true;
      };

      taps = [
        "qmk/qmk"
        "homebrew/cask-fonts"
      ];

      brews = [
        # Common CLI tools
        "neovim"
        "jq"
        "yq"
        "htop"
        "tmux"
        "tree"
        "yqrashawn/goku/goku"
        # "ghostty"
        "ripgrep"
        "go"
        "uv"
        "python"
        "python@3.11"
        "ruff"
        "node"
        "fzf"
        "neofetch"
        # "devcontainer"
        "pre-commit"
        "fd" # Simple, fast and user-friendly alternative to find
        "gh"
      ]
      ++ lib.optionals (!isCorporate) [
        # Private-only brews
        "qmk/qmk/qmk"
        # "php"
        "mole" # Fast, highly customisable system info script
        "glib"
        # "minikube"
        # "openjdk"
        # "maven"
        # "gradle"
      ]
      ++ lib.optionals isCorporate [
        # Corporate-only brews
        "awscli"
        "saml2aws"
        # "vault"
      ];

      casks = [
        # Common GUI apps
        "arc"
        "dbeaver-community"
        "hammerspoon"
        "font-hack-nerd-font"
        "karabiner-elements"
        "spectacle"
        # "rectangle"
        "spotify"
        "stats"
        "rar"
        "hiddenbar"
        "logi-options+"
        # "zen"
        # "vscodium"
        # "raycast"
      ]
      ++ lib.optionals (!isCorporate) [
        # Private-only casks
        "vlc"
        "qbittorrent"
        "obsidian"
      ]
      ++ lib.optionals isCorporate [
        # Corporate-only casks
        # "slack"
        # "zoom"
        # "1password"
      ];

      # masApps = lib.mkMerge [
      #   {
      #     # Common Mac App Store apps
      #   }
      #   (lib.mkIf isCorporate {
      #     # Corporate-only Mac App Store apps
      #     "Microsoft Word" = 462054704;
      #     "Microsoft Excel" = 462058435;
      #   })
      # ];
    };
  };
}
