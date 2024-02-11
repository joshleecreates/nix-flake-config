{ config, pkgs, lib, ... }:

{
  # Home Manager needs a bit of information about you and the paths it should
  # manage.
  home.username = "joshlee";
  home.homeDirectory = "/Users/joshlee";

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
    pkgs.elixir
    pkgs.elixir-ls
    pkgs.zoxide
    pkgs.fzf
    pkgs.vscode-langservers-extracted
    pkgs.qutebrowser
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
}
