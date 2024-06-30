{ config, pkgs, lib, ... }:

{
  # Home Manager needs a bit of information about you and the paths it should
  # manage.
  home.username = "josh";
  home.homeDirectory = lib.mkForce "/Users/josh";

  home.stateVersion = "23.11"; # Please read the comment before changing.

  imports = [
    ../modules/home-manager/neovim.nix
    ../modules/home-manager/tmux.nix
    ../modules/home-manager/zsh.nix
    ../modules/home-manager/git.nix
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
    pkgs.gh
    pkgs.opentofu
    pkgs.yabai
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

  programs.zsh = {
    initExtra = ''
      eval "$(/opt/homebrew/bin/brew shellenv)"
    '';
  };
}
