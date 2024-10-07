{ pkgs, ... }:
{
  programs.git = {
    userName = "Joshua Lee";
    userEmail = "josh@joshuamlee.com";
    enable = true;
    delta = {
      enable = true;
    };
    extraConfig = {
      pull = {
        rebase = true;
      };
      init = {
        defaultBranch = "main";
      };
    };
  };
}
