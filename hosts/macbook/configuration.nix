{ config, pkgs, ...}:

let user = "josh"; in 

{
  imports = [
    ./homebrew.nix
  ];
  users.users.${user} = {
    isHidden = false;
    shell = pkgs.zsh;
  };

  home-manager.users.${user} = {
    imports = [ ./home.nix ];
  };

  services.nix-daemon.enable = true;

  # Setup user, packages, programs
  nix = {
    package = pkgs.nix;
    settings.trusted-users = [ "@admin" "${user}" ];

    gc = {
      user = "root";
      automatic = true;
      interval = { Weekday = 0; Hour = 2; Minute = 0; };
      options = "--delete-older-than 30d";
    };

    # Turn this on to make command line easier
    extraOptions = ''
      experimental-features = nix-command flakes
    '';
  };

  # Turn off NIX_PATH warnings now that we're using flakes
  system.checks.verifyNixPath = false;
}
