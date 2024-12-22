{ pkgs, config, ... }:

{
  age.secrets.nixarr-wg = {
    file = ./secrets/nixarr-wg.age;
    owner = "nixarr";
    group = "nixarr";
  };

  nixarr = {
    enable = true;
    # These two values are also the default, but you can set them to whatever
    # else you want
    # WARNING: Do _not_ set them to `/home/user/whatever`, it will not work!
    mediaDir = "/data/";
    stateDir = "/data/media/.state/nixarr";

    vpn = {
      enable = true;
      # WARNING: This file must _not_ be in the config git directory
      # You can usually get this wireguard file from your VPN provider
      wgConf = config.age.secrets.nixarr-wg.path;
    };

    transmission = {
      enable = true;
      vpn.enable = true;
      peerPort = 63993; # Set this to the port forwarded by your VPN
    };

    # It is possible for this module to run the *Arrs through a VPN, but it
    # is generally not recommended, as it can cause rate-limiting issues.
    bazarr.enable = true;
    lidarr.enable = true;
    prowlarr.enable = true;
    radarr.enable = true;
    readarr.enable = true;
    #    sonarr.enable = true;
  };
  services.jellyseerr.enable = true;
  services.jellyfin.enable = true;

}