{ config, pkgs, lib, ... }:

{
  # Home Manager needs a bit of information about you and the paths it should
  # manage.
  home.username = "josh";
  home.homeDirectory = "/home/josh";

  home.stateVersion = "23.11"; # Please read the comment before changing.

  imports = [
    ./neovim.nix
    ./tmux.nix
    ./zsh.nix
  ];

  # The home.packages option allows you to install Nix packages into your
  # environment.
  home.packages = [
    pkgs.thefuck
    pkgs.oh-my-zsh
    pkgs.git
    pkgs.wget
    pkgs.gnumake
    pkgs.ranger
    pkgs.zoxide
    pkgs.fzf
  ];

  home.sessionVariables = {
    EDITOR = "nvim";
    T_REPOS_DIR = "~/repos";
  };

  # Let Home Manager install and manage itself.
  programs.home-manager.enable = true;

  programs.htop = {
    enable = true;
  };
}
