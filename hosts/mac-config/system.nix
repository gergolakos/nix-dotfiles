{ pkgs, inputs, userConfig, ... }:
{
  # Auto upgrade nix package and the daemon service.
  nix = {
    enable = true;
    settings = {
      experimental-features = [
        "nix-command"
        "flakes"
      ];
      auto-optimise-store = true;
    };
    package = pkgs.lixPackageSets.latest.lix;
  };

  # Set the nixbld group GID to match your system's nixbld group (350)
  # If you are setting up a new host, this is not necessary.
  ids.gids.nixbld = 350;

  system = {
    primaryUser = "${userConfig.name}";
    stateVersion = 4;
    defaults = {
      # Log out and back in to apply the defaults.
      NSGlobalDomain = {
        AppleShowAllExtensions = true;
        KeyRepeat = 2; # Options: 120, 90, 60, 30, 12, 6, 2 (Fastest: 2)
        InitialKeyRepeat = 15; # (Fastest: 15)
      };
      dock = {
        autohide = true;
        show-recents = false;
        launchanim = true;
        mouse-over-hilite-stack = false;
        orientation = "bottom";
        tilesize = 20;
      };
    };
  };
}
