# nix-dotfiles

- `home-manager` – user-level configurations
- `hosts` – OS-level configurations

## TODO/Backlog

- [x] Modularize the system settings
- [ ] Apply all current macOS settings through Nix
- [x] Define company, common, and private packages
- [x] Set up company, common, and private macOS configurations
- [x] Configure company, common, and private home-manager settings

- move ghostty install to homebrew
- revisit git
- move dotfiles to the new repo
- zsh, ohmyzsh, fzf setup
- nix-homebrew installation

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

## Nix Darwin

3 commands to rule them all:

```bash
# intall nix
sh <(curl --proto '=https' --tlsv1.2 -L https://nixos.org/nix/install)
# download my nix dotfiles (public config)
nix-shell -p git --run 'git clone https://github.com/glakos/nix-dotfiles.git .dotfiles'
# install it
nix run nix-darwin --extra-experimental-features 'nix-commands flakes' -- switch --flake ~/nix-dotfiles/nix/darwin#gelakos
```

Run flakes:

```bash
sudo nix run nix-darwin -- switch --flake .#mac-config
nix run home-manager -- switch --flake .#m1-air-personal@glakos

# Cleanup
nix store gc

# Search packages
nix search nixpkgs ghostty
nix-env -qaP ghostty

# Update flake
sudo nix flake update

# Rollback
sudo darwin-rebuild --list-generations
sudo darwin-rebuild switch --rollback
```

## Flake init in projects

```bash
nix flake init
vim flake.nix
nix develop
```

## Good to know

- note that nix-darwin supports Homebrew, but programs.homebrew is deprecated as nix encourages using nix packages instead

## Starting Home Manager activation Issue

Error message

```
Starting Home Manager activation
Activating checkAppManagementPermission
error: permission denied when trying to update apps over SSH, aborting activation
Apps could not be updated as home-manager requires Full Disk Access to work over SSH.
You can either:

  grant Full Disk Access to all programs run over SSH

or

  run home-manager in a graphical session.

The option "Allow full disk access for remote users" can be found by
navigating to System Settings > General > Sharing > Remote Login
and then pressing on the i icon next to the switch.
```

Manually deleting `~/Application/Home Manager Apps` resolved the issue.

## Links

- https://www.nixhub.io/
- https://search.nixos.org/packages
- https://rycee.gitlab.io/home-manager/options.xhtml#opt-home.activation
- https://github.com/nix-darwin/nix-darwin/blob/master/CHANGELOG
