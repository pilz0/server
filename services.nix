{ pkgs, config, ... }:
{
  services.jellyfin = {
    enable = true;
    openFirewall = true;
    #  dataDir = "/home/marie/jellyfin_data";
  };
  # 1. enable vaapi on OS-level
  nixpkgs.config.packageOverrides = pkgs: {
    vaapiIntel = pkgs.vaapiIntel.override { enableHybridCodec = true; };
  };
  services.radarr = {
    enable = true;
  };
  services.bazarr = {
    enable = true;
  };
  services.sonarr = {
    enable = true;
  };
  services.lidarr = {
    enable = true;
  };
  services.prowlarr = {
    enable = true;
  };

  boot.initrd.kernelModules = [ "nvidia" ];
  #  boot.extraModulePackages = [ config.boot.kernelPackages.nvidia_x11 ];
  hardware.graphics = {
    enable = true;
    extraPackages = with pkgs; [
      intel-media-driver
      intel-vaapi-driver # previously vaapiIntel
      vaapiVdpau
      intel-compute-runtime # OpenCL filter support (hardware tonemapping and subtitle burn-in)
      intel-media-sdk # QSV up to 11th gen
    ];
  };

  # services.xserver.enable = true;
  services.xserver.videoDrivers = [ "nvidia" ];
  services.xserver.enable = true;

  hardware.nvidia = {
    modesetting.enable = true;
    powerManagement.enable = false;
    nvidiaSettings = true;
    powerManagement.finegrained = false;
    open = false;
    package = config.boot.kernelPackages.nvidiaPackages.beta;
  };

  virtualisation.docker.enable = true;
  virtualisation.containerd.enable = true;
  services.tailscale.enable = true;
  programs.git.config.user.name = "pilz0";
  programs.git.config.user.email = "marie0@riseup.net";

  services.ollama = {
    enable = true;
    acceleration = "cuda";
  };
  services.open-webui = {
    enable = true;
    port = 2315;
  };

  services.writefreely = {
    #    enable = true;
    admin.name = "marie";
    host = "flohannes.de";
    database = {
      type = "sqlite3";
    };
    nginx = {
      enable = true;
      forceSSL = true;
    };
    acme = {
      enable = true;
    };
  };

  environment.etc."nextcloud-admin-pass".text = "lDtdt4sZx5LBnYbdUSM"; # just a default pw
  services.nextcloud = {
    enable = true;
    maxUploadSize = "20G";
    appstoreEnable = true;
    extraAppsEnable = true;
    package = pkgs.nextcloud30;
    hostName = "cloud.ketamin.trade";
    # home = "";
    caching = {
      apcu = false;
      redis = true;
    };
    config = {
      adminpassFile = "/etc/nextcloud-admin-pass";
      dbhost = "/run/postgresql";
      dbtype = "pgsql";
      dbuser = "nextcloud";
    };
    settings = {
      default_phone_region = "DE";
      trusted_proxies = [
        "127.0.0.1"
        "::1"
      ];
    };
    poolSettings = {
      "pm" = "dynamic";
      "pm.max_children" = "120";
      "pm.max_requests" = "500";
      "pm.max_spare_servers" = "18";
      "pm.min_spare_servers" = "6";
      "pm.start_servers" = "12";
    };
    https = true;
  };
  services.redis.servers.nextcloud = {
    enable = true;
    bind = "::1";
    port = 6379;
  };

  services.postgresql = {
    ensureDatabases = [ config.services.nextcloud.config.dbname ];
    ensureUsers = [
      {
        name = config.services.nextcloud.config.dbuser;
        ensureDBOwnership = true;
      }
    ];
  };
  services.postgresqlBackup.databases = [ config.services.nextcloud.config.dbname ];
  systemd.services.nextcloud-setup.serviceConfig.ExecStartPost = pkgs.writeScript "nextcloud-redis.sh" ''
    #!${pkgs.runtimeShell}
    nextcloud-occ config:system:set redis 'host' --value '::1' --type string
    nextcloud-occ config:system:set redis 'port' --value 6379 --type integer
    nextcloud-occ config:system:set memcache.local --value '\OC\Memcache\Redis' --type string
    nextcloud-occ config:system:set memcache.locking --value '\OC\Memcache\Redis' --type string
  '';

}
