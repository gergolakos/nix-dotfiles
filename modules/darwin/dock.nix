{ config, pkgs, ... }:

{
  services.dock = {
    enable = true;
    autohide = false;
    show-recents = false;
    orientation = "top";
    persistent-apps = [];
  };
}

