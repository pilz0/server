{ pkgs, ... }:
{
  #    services.unifi = {
  #      enable = true;
  #      openFirewall = true;
  #      unifiPackage = pkgs.unifi8;
  #   };

  #  services.unifi.mongodbPackage = pkgs.mongodb-7_0;
  networking.networkmanager.enable = true;
  networking.hostName = "serva";
  networking.extraHosts = ''
    127.0.0.1 cloud.ketamin.trade 
  '';
  services.unpoller = {
    #   enable = true;
    influxdb.disable = true;
    unifi = {
      defaults = {
        url = "https://localhost:8443";
        user = "unpoller";
        pass = "/srv/password";
        verify_ssl = false;
      };
    };
  };
  networking.firewall = {
    allowedTCPPorts = [
      "22"
      "80"
      "443"
      "1100"
      "8090"
      "9001"
      "9002"
      "9003"
      "9004"
      "9005"
    ];
  };
}
