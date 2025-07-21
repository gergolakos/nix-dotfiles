{ config, pkgs, ... }:

{
  programs.git = {
    enable = true;
    userName = "Your Name";
    userEmail = "your@email.com";
    ignores = [ ".DS_Store" "node_modules/" ];
    extraConfig = {
      core.editor = "nvim";
      init.defaultBranch = "main";
    };
  };
}

