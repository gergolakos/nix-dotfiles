{ pkgs, userConfig, ... }:

{
  # Import submodules
  imports = [
    ./core.nix
    ./dock.nix
    ./homebrew.nix
    ./finder.nix
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
      trusted-users = [
        "root"
        userConfig.name
      ];
    };
    gc = {
      automatic = true;
      interval = {
        Weekday = 0;
        Hour = 2;
        Minute = 0;
      };
      options = "--delete-older-than 10d";
    };
    package = pkgs.lixPackageSets.latest.lix;
  };

  # Set the nixbld group GID to match your system's nixbld group (350)
  # If you are setting up a new host, this is not necessary.
  ids.gids.nixbld = 350;

  system = {
    # Turn off NIX_PATH warnings now that we're using flakes
    checks.verifyNixPath = false;
    primaryUser = "${userConfig.name}";
    stateVersion = 4;
    defaults = { };
  };
}
