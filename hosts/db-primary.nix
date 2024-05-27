{ pkgs, ... }:
{
  imports = [
    ./templates/server.nix
  ];

  networking.hostName = "db-primary";

  networking.firewall = {
    enable = true;
    allowedTCPPorts = [ 22 5432 ];
  };

  services.postgresql = {
    enable = true;
    enableTCPIP = true;
    ensureDatabases = [ "grafana" ];
    ensureUsers = [{
      name = "grafana";
      ensureDBOwnership = true;
      ensureClauses.login = true;
    }];

    authentication = pkgs.lib.mkOverride 10 ''
      local all all trust
      host  all all all trust
    '';
    initialScript = pkgs.writeText "backend-initScript" ''
      CREATE ROLE grafana WITH LOGIN password 'grafana' CREATEDB;
      CREATE DATABASE grafana;
      GRANT ALL PRIVILEGES ON DATABASE grafana TO grafana;
    '';
  };
}
