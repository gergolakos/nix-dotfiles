{ ... }:

{
  # Log out and back in to apply the defaults.
  system.defaults.NSGlobalDomain = {
    AppleShowAllExtensions = true;
    KeyRepeat = 2; # Options: 120, 90, 60, 30, 12, 6, 2 (Fastest: 2)
    InitialKeyRepeat = 15; # (Fastest: 15)
  };
}
