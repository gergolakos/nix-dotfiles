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
        "git"
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
        # "terraform"
        "tfenv"
        "terragrunt"
        "tflint"
        "terraform-docs"
        "tree-sitter-cli"
        "hcledit"
        "mas"
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
        "hcloud"
        "wireguard-tools"
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
        # "jordanbaird-ice"
        "logi-options+"
        # "zen"
        # "vscodium"
        # "raycast"
        "claude-code"
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

      # New Brewfile entry types were added: `homebrew.goPackages`,
      # `homebrew.cargoPackages`, and `homebrew.vscode`
      goPackages = [ ];
      vscode = [
        # "asvetliakov.vscode-neovim"
        # "pkief.material-icon-theme"
      ];

      # masApps = {
      #   "wireguard" = 1451685025;
      # };
      # masApps doesn't work reliably via brew bundle
      # Install manually: mas install <id>
      # You need to be signed into the Mac App Store

    };
  };
}
