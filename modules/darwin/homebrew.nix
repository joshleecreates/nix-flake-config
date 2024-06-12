{ ... }: {
  homebrew = {
    enable = true;
    global = { autoUpdate = false; };
    # will not be uninstalled when removed
    # onActivation = {
    #   # "zap" removes manually installed brews and casks
    #   cleanup = "zap";
    #   autoUpdate = false;
    #   upgrade = false;
    # };
    brews = [
      "sniffnet" # monitor network traffic
      "sketchybar"
    ];
    casks = [
      # utilities
      # "hiddenbar" # hides menu bar icons
      "meetingbar" # shows upcoming meetings
      # "skhd"
      # "yabai"
      "font-hack-nerd-font" #fors sketchy bar

      # virtualization
      # "utm" # virtual machines

      # communication
      "zoom"
      # "slack"
      # "discord"
      
      # "bitwarden" # password manager
      # "spotify" # music
      # "obs" # stream / recoding software
      "eul" # mac monitoring
      "wireshark" # network sniffer
      # "obsidian" # zettelkasten
    ];
    taps = [
      # default
      "homebrew/bundle"
      "homebrew/services"
      # custom
      "FelixKratz/formulae" # borders
    ];
  };
}
