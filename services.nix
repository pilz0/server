{
  pkgs,
  config,
  libs,
  ...
}:
{
  age.secrets.writefreely = {
    file = ./secrets/writefreely.age;
    owner = "writefreely";
    group = "writefreely";
  };

  services.jellyfin = {
    enable = true;
  };
  services.radarr = {
    enable = true;
  };
  services.bazarr = {
    enable = true;
  };
  #  services.sonarr = {
  #    enable = true;
  #  };

  # https://discourse.nixos.org/t/solved-sonarr-is-broken-in-24-11-unstable-aka-how-the-hell-do-i-use-nixpkgs-config-permittedinsecurepackages/56828
  services.lidarr = {
    enable = true;
  };
  services.prowlarr = {
    enable = true;
  };
  services.jellyseerr = {
    enable = true;
  };

  virtualisation.docker.enable = true;
  virtualisation.containerd.enable = true;
  services.tailscale.enable = true;
  programs.git.config.user.name = "pilz0";
  programs.git.config.user.email = "marie0@riseup.net";

  #  services.ollama = {
  #    enable = true;
  #    acceleration = "cuda";
  #    loadModels = [ "llama3.2" ];
  #  };
  #  services.open-webui = {
  #    enable = true;
  #    port = 2315;
  #  };

  services.bird-lg = {
    frontend = {
      domain = "lg.ketamin.trade";
      enable = true;
      servers = [ "serva" ];
      protocolFilter = [
        "bgp"
        "static"
      ];
      listenAddress = "[::1]:15000";
      proxyPort = 18000;
      navbar = {
        brand = "cybertrash";
      };
    };
  };

  services.writefreely = {
    enable = true;
    admin = {
      name = "marie";
      initialPasswordFile = config.age.secrets.writefreely.path;
    };
    group = "writefreely";
    user = "writefreely";
    settings.app.theme = "Painkiller Bullet";
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
}
