{ pkgs, ... }:
{
  home.packages = [
    pkgs.oh-my-zsh
  ];

  programs.zsh = {
    enable = true;
    enableCompletion = true;
    dotDir = ".config/zsh";
    syntaxHighlighting.enable = true;
    shellAliases = {
      ll = "ls -l";
      ta = "tmux attach";
      n = "nvim .";
    };
    initExtra = ''
      eval "$(zoxide init zsh)"
    '';
  };
}
