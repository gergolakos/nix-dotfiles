{ config, lib, pkgs, isCorporate, ... }:

{
  options = {
    my.dock.enable = lib.mkEnableOption "Enable custom macOS Dock configuration";
  };

  config = lib.mkIf config.my.dock.enable {
    system.defaults.dock = {
      autohide = true;
      tilesize =
        if isCorporate # testing isCorporate flag
        then 100
        else 20;
      show-recents = false;
      launchanim = true;
      mouse-over-hilite-stack = false;
      orientation = "bottom";
    };
  };
}
