{ pkgs, ... }:
{
  #    services.unifi = {
  #      enable = true;
  #      openFirewall = true;
  #      unifiPackage = pkgs.unifi8;
  #   };

  #  services.unifi.mongodbPackage = pkgs.mongodb-7_0;
  networking.networkmanager.enable = true;
  networking.nameservers = [ "1.1.1.1" "9.9.9.9" ];
  networking.hostName = "serva";
  networking.extraHosts = ''
    127.0.0.1 cloud.ketamin.trade
    172.22.179.129 serva.lg.ketamin.trade
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
      22 #ssh
      80 #http
      443 #https
      179 #bgp
      1100 #nextcloud-docker
      8090 #qbittorrent
      9001 #routerlab
      9002 #routerlab
      9003 #routerlab
      9004 #routerlab
      9005 #routerlab
    ];
    allowedUDPPorts = [
      22 #ssh
      80 #http
      443 #https
      179 #bgp
      1100 #nextcloud-docker
      8090 #qbittorrent
      9001 #routerlab
      9002 #routerlab
      9003 #routerlab
      9004 #routerlab
      9005 #routerlab
    ];
  };
}
