{
  config,
  lib,
  pkgs,
  isCorporate,
  ...
}:

{
  options = {
    my.finder.enable = lib.mkEnableOption "Enable custom macOS Finder configuration";
  };

  config = lib.mkIf config.my.finder.enable {
    system.defaults.finder = {
      # Show full path in title bar
      _FXShowPosixPathInTitle = false;

      # Show path bar at bottom
      ShowPathbar = true;

      # Show status bar at bottom
      ShowStatusBar = false;

      # Default view style (icnv/Nlsv/clmv/glyv)
      FXPreferredViewStyle = "Nlsv"; # list view

      # Search in current folder by default
      FXDefaultSearchScope = "SCcf";

      # Don't warn when changing file extension
      FXEnableExtensionChangeWarning = false;

      # Default new window location
      NewWindowTarget = "Home";

      # Finder: show hidden files by default
      AppleShowAllFiles = true;
    };
    system.defaults.screencapture.location = "~/Downloads";
  };
}

# trackpad = {
#   Clicking = true;
#   TrackpadThreeFingerDrag = true;
# };
