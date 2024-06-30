{ pkgs, ... }:
{
  home.packages = [
  ];

  programs.zsh = {
    enable = true;
    enableCompletion = true;
    dotDir = ".config/zsh";
    oh-my-zsh = {
      enable = true;
      theme = "bira";
    };
    shellAliases = {
      ll = "ls -l";
      ta = "tmux attach";
      n = "nvim .";
    };
    initExtra = ''
      eval "$(zoxide init zsh)"
      autoload bashcompinit && bashcompinit
      autoload -Uz compinit && compinit
      complete -C '/usr/local/bin/aws_completer' aws
    '';
  };
}
