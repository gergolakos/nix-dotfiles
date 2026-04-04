{ nixDarwinModules, lib, ... }:
{
  imports = [
    "${nixDarwinModules}/system"
  ];

  my.dock.enable = true;
  my.homebrew.enable = true;
  my.finder.enable = true;

  # Optionally use `mkForce` to override values
  # system.defaults.dock.tilesize = lib.mkForce 100;
}
