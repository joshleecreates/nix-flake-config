{ config, pkgs, lib, ... }:

{
  # Home Manager needs a bit of information about you and the paths it should
  # manage.
  home.username = "josh";

  home.homeDirectory = "/home/josh";

  home.stateVersion = "23.11"; # Please read the comment before changing.

  imports = [
    ../modules/home-manager/neovim.nix
    ../modules/home-manager/tmux.nix
    ../modules/home-manager/git.nix
    ../modules/home-manager/zsh.nix
  ];

  # The home.packages option allows you to install Nix packages into your
  # environment.
  home.packages = [
    pkgs.thefuck
    pkgs.git
    pkgs.wget
    pkgs.gnumake
    pkgs.ranger
    pkgs.vscode-langservers-extracted
    pkgs.nurl
    pkgs.btop
    pkgs.dnsutils
    pkgs.kubectl
    pkgs.kubectx
    pkgs.opentofu
  ];

  home.sessionVariables = {
    EDITOR = "nvim";
    T_REPOS_DIR = "$HOME/repos";
  };

  # Let Home Manager install and manage itself.
  programs.home-manager.enable = true;

  programs.htop = {
    enable = true;
  };

  programs.ssh.enable = true;
  programs.ssh.matchBlocks = {
    "new-vm.local" = {
      checkHostIP = false;
    };
  };

  programs.zsh = {
    enable = true;
    oh-my-zsh = {
      enable = true;
      plugins = [ "git" "thefuck" "kubectl" "vi-mode" "docker" ];
      theme = "bira";
    };
  };
}
