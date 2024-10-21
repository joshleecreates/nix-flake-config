{ pkgs, ... }:
{
  home.packages = [
  ];

  programs.zsh = {
    enable = true;
    enableCompletion = true;
    dotDir = ".config/zsh";
<<<<<<< HEAD
    syntaxHighlighting.enable = true;
=======
    oh-my-zsh = {
      enable = true;
      theme = "robbyrussell";
      plugins = ["kubectl" "kubectx" "git" "aws"];
    };
>>>>>>> origin/darwin
    shellAliases = {
      ll = "ls -l";
      ta = "tmux attach";
      n = "nvim .";
      k = "kubectl";
      tmux-left = "tmux set-option status-left-length 40";
    };
    initExtra = ''
      eval "$(zoxide init zsh)"

<<<<<<< HEAD
=======
      # aws cli auto complete
      complete -C '${pkgs.awscli}/bin/aws_completer' aws

>>>>>>> origin/darwin
      DISABLE_AUTO_TITLE="true"
    '';
  };
}
