{ ... }: {
  programs.zsh.shellAliases.ks =
    "XDG_CONFIG_HOME=~/.config XDG_DATA_HOME=~/.config k9s";
  programs.k9s = {
    enable = true;
    settings.k9s = {
      ui = {
        headless = true;
        logoless = true;
        noIcons = true;
      };
      skipLatestRevCheck = true;
    };
  };
}
