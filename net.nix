{ pkgs, ... }:
{
  services.unifi = {
    enable = true;
    openFirewall = true;
    unifiPackage = pkgs.unifi8;
  };
  networking.networkmanager.enable = true;
  networking.hostName = "serva";
  services.unpoller = {
    enable = true;
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
      1100
      11000
      81
      8080
      443
      80
      22
      3000
      8443
      1337
      3001
      9090
      9100
      1312
      8090
    ];
    allowedUDPPorts = [
      1100
      11000
      81
      8080
      443
      80
      22
      3000
      8443
      1337
      3001
      9090
      9100
      1312
      17871
    ];
  };

}
