{ pkgs, ... }:
{
  programs.zsh = {
    enable = true;
    enableCompletion = true;
    dotDir = ".config/zsh";
    syntaxHighlighting.enable = true;
    plugins = [
      {
        name = "powerlevel10k-config";
        src = ./config/zsh;
        file = "p10k.zsh";
      }
      {
        name = "powerlevel10k";
        src = pkgs.zsh-powerlevel10k;
        file = "share/zsh-powerlevel10k/powerlevel10k.zsh-theme";
      }
    ];
    oh-my-zsh = {
      enable = true;
      plugins = [ "git" "thefuck" "kubectl" "vi-mode" "docker" ];
    };
    shellAliases = {
      ll = "ls -l";
      update = "sudo nixos-rebuild switch";
    };
  };
}
