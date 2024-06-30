{ config, ... }: {
  homebrew = {
    enable = true;
    brews = [
      "sniffnet" # monitor network traffic
      "sketchybar"
    ];
    casks = [
      # utilities
      "meetingbar" # shows upcoming meetings
      "font-hack-nerd-font" #fors sketchy bar

      # virtualization
      "utm" # virtual machines

      # communication
      "zoom"
      "slack"
      "discord"
      
      "arc"
      "1password" # password manager
      "spotify" # music
      "obs" # stream / recoding software
      "eul" # mac monitoring
      "wireshark" # network sniffer
      "obsidian" # zettelkasten
      "firefox"
      "iterm2"
      "amethyst"
      "visual-studio-code"
      "docker"
      "spacelauncher"
      "ubersicht"
      "syncthing"
    ];
    
    taps = map (key: builtins.replaceStrings ["homebrew-"] [""] key) (builtins.attrNames config.nix-homebrew.taps);
  };
}
