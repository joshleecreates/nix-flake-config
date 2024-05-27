{ ... }:

{ 
  services.openssh = {
    enable = true;
    settings.PasswordAuthentication = false;
    settings.KbdInteractiveAuthentication = false;
  };
  programs.ssh.startAgent = true;
}
