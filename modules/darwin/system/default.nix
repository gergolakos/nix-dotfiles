{ pkgs, userConfig, ... }:

{
  # Import submodules
  imports = [
    ./core.nix
    ./dock.nix
  ];

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
    gc = {
      automatic = true;
      interval = { Weekday = 0; Hour = 2; Minute = 0; };
      options = "--delete-older-than 10d";
    };
    package = pkgs.lixPackageSets.latest.lix;
  };

  # Set the nixbld group GID to match your system's nixbld group (350)
  # If you are setting up a new host, this is not necessary.
  ids.gids.nixbld = 350;

  system = {
    primaryUser = "${userConfig.name}";
    stateVersion = 4;
    defaults = {};
  };
}

