{ config, ... }:

{
  age.secrets.nixarr-wg = {
    file = ./secrets/nixarr-wg.age;
    owner = "nixarr";
    group = "nixarr";
  };

  nixarr = {
    enable = true;
    mediaDir = "/data/";
    stateDir = "/data/media/.state/nixarr";

    vpn = {
      enable = true;
      wgConf = config.age.secrets.nixarr-wg.path;
    };

    transmission = {
      enable = true;
      vpn.enable = true;
      peerPort = 63993; # Set this to the port forwarded by your VPN
      extraSettings = {
    speed-limit-up-enabled = true;
    speed-limit-up = 700;
    };
    };

    bazarr.enable = true;
    lidarr.enable = true;
    prowlarr.enable = true;
    radarr.enable = true;
    readarr.enable = true;
    #    sonarr.enable = true; # I FUCKING HATE SONARR
  };
  services.jellyseerr.enable = true;
  services.jellyfin.enable = true;

}
