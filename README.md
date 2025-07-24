# nix-dotfiles

- `home-manager` – user-level configurations
- `hosts` – OS-level configurations

## TODO/Backlog

- [ ] Modularize the system settings
- [ ] Apply all current macOS settings through Nix
- [ ] Define company, common, and private packages
- [ ] Set up company, common, and private macOS configurations
- [ ] Configure company, common, and private home-manager settings

## Structure

- `flake.nix`: The flake itself, defining inputs and outputs for NixOS, nix-darwin, and Home Manager configurations.
- `hosts/`: NixOS and nix-darwin configurations for each machine
- `home-manager/`: Home Manager configurations for each machine
- `files/`: Miscellaneous configuration files and scripts used across various applications and services
- `modules/`: Reusable platform-specific modules
  - `nixos/`: NixOS-specific modules
  - `darwin/`: macOS-specific modules
  - `home-manager/`: User-space configuration modules
- `flake.lock`: Lock file ensuring reproducible builds by pinning input versions
- `overlays/`: Custom Nix overlays for package modifications or additions

Ideas were inspired by: https://github.com/AlexNabokikh/nix-config

cat /run/current-system/sw/bin/bash
