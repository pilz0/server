{ pkgs, config, ... }:
{
  services.nginx = {
    enable = true;
    recommendedGzipSettings = true;
    recommendedOptimisation = true;
    recommendedProxySettings = true;
    recommendedTlsSettings = true;
    # other Nginx options
    virtualHosts."routerlab1.ketamin.trade" = {
      enableACME = true;
      forceSSL = true;
      basicAuth = {
        foo = "foo";
      };
      locations."/" = {
        proxyPass = "http://10.10.1.22:9001";
        proxyWebsockets = true; # needed if you need to use WebSocket
      };
    };
    virtualHosts."routerlab2.ketamin.trade" = {
      enableACME = true;
      forceSSL = true;
      basicAuth = {
        foo = "foo";
      };
      locations."/" = {
        proxyPass = "http://10.10.1.22:9002";
        proxyWebsockets = true; # needed if you need to use WebSocket
      };
    };
    virtualHosts."routerlab3.ketamin.trade" = {
      enableACME = true;
      forceSSL = true;
      basicAuth = {
        foo = "foo";
      };
      locations."/" = {
        proxyPass = "http://10.10.1.22:9003";
        proxyWebsockets = true; # needed if you need to use WebSocket
      };
    };
    virtualHosts."routerlab4.ketamin.trade" = {
      enableACME = true;
      forceSSL = true;
      basicAuth = {
        foo = "foo";
      };
      locations."/" = {
        proxyPass = "http://10.10.1.22:9004";
        proxyWebsockets = true; # needed if you need to use WebSocket
      };
    };
    virtualHosts."routerlab5.ketamin.trade" = {
      enableACME = true;
      forceSSL = true;
      basicAuth = {
        foo = "foo";
      };
      locations."/" = {
        proxyPass = "http://10.10.1.22:9005";
        proxyWebsockets = true; # needed if you need to use WebSocket
      };
    };
    virtualHosts.${config.services.grafana.settings.server.domain} = {
      enableACME = true;
      forceSSL = true;
      locations."/" = {
        proxyPass = "http://localhost:3001";
        proxyWebsockets = true; # needed if you need to use WebSocket
      };
    };
    virtualHosts."caffeine.mom" = {
      enableACME = true;
      forceSSL = true;
      locations."/" = {
        proxyPass = "http://localhost:8096";
        proxyWebsockets = true; # needed if you need to use WebSocket
      };
    };
    virtualHosts."cloud.fffda.lol" = {
      enableACME = true;
      forceSSL = true;
      locations."/" = {
        proxyPass = "http://10.10.1.22:1100";
        proxyWebsockets = true; # needed if you need to use WebSocket
      };
    };
    virtualHosts."unifi.ketamin.trade" = {
      enableACME = true;
      forceSSL = true;
      locations."/" = {
        proxyPass = "http://localhost:8443";
        proxyWebsockets = true; # needed if you need to use WebSocket
      };
    };
    virtualHosts."radarr.ketamin.trade" = {
      enableACME = true;
      forceSSL = true;
      locations."/" = {
        proxyPass = "http://localhost:7878";
        proxyWebsockets = true; # needed if you need to use WebSocket
      };
    };
    virtualHosts."bazarr.ketamin.trade" = {
      enableACME = true;
      forceSSL = true;
      locations."/" = {
        proxyPass = "http://localhost:6767";
        proxyWebsockets = true; # needed if you need to use WebSocket
      };
    };
    virtualHosts."sonarr.ketamin.trade" = {
      enableACME = true;
      forceSSL = true;
      locations."/" = {
        proxyPass = "http://localhost:8989";
        proxyWebsockets = true; # needed if you need to use WebSocket
      };
    };
    virtualHosts."prowlarr.ketamin.trade" = {
      enableACME = true;
      forceSSL = true;
      locations."/" = {
        proxyPass = "http://localhost:9696";
        proxyWebsockets = true; # needed if you need to use WebSocket
      };
    };
    virtualHosts."lidarr.ketamin.trade" = {
      enableACME = true;
      forceSSL = true;
      locations."/" = {
        proxyPass = "http://localhost:8686";
        proxyWebsockets = true; # needed if you need to use WebSocket
      };
    };
    virtualHosts."jellyseerr.ketamin.trade" = {
      enableACME = true;
      forceSSL = true;
      locations."/" = {
        proxyPass = "http://localhost:5055";
        proxyWebsockets = true; # needed if you need to use WebSocket
      };
    };
    virtualHosts."jellyseerr.dn42.ketamin.trade" = {
      enableACME = false;
      forceSSL = false;
      locations."/" = {
        proxyPass = "http://localhost:5055";
        proxyWebsockets = true; # needed if you need to use WebSocket
      };
    };
    virtualHosts."lists.ketamin.trade" = {
      enableACME = true;
      forceSSL = true;
      locations."/" = {
        proxyPass = "http://localhost:61015";
        proxyWebsockets = true; # needed if you need to use WebSocket
      };
    };
    virtualHosts."torrent.ketamin.trade" = {
      enableACME = true;
      forceSSL = true;
      locations."/" = {
        proxyPass = "http://10.10.1.22:8090";
        proxyWebsockets = true; # needed if you need to use WebSocket
      };
    };
    virtualHosts."vm1.serva.ketamin.trade" = {
      enableACME = true;
      forceSSL = true;
      extraConfig = ''
        allow 130.83.0.0/16; # TU-Darmstadt | AS8365
        allow 82.195.64.0/19; # Man-da | AS8365
        deny all;
      '';
      locations."/" = {
        proxyPass = "http://10.10.1.22:6901";
        proxyWebsockets = true; # needed if you need to use WebSocket
      };
    };
    virtualHosts."vm2.serva.ketamin.trade" = {
      enableACME = true;
      forceSSL = true;
      extraConfig = ''
        allow 130.83.0.0/16; # TU-Darmstadt | AS8365
        allow 82.195.64.0/19; # Man-da | AS8365
        deny all;
      '';
      locations."/" = {
        proxyPass = "http://10.10.1.22:6902";
        proxyWebsockets = true; # needed if you need to use WebSocket
      };
    };
    virtualHosts."vm3.serva.ketamin.trade" = {
      enableACME = true;
      forceSSL = true;
      extraConfig = ''
        allow 130.83.0.0/16; # TU-Darmstadt | AS8365
        allow 82.195.64.0/19; # Man-da | AS8365
        deny all;
      '';
      locations."/" = {
        proxyPass = "http://10.10.1.22:6903";
        proxyWebsockets = true; # needed if you need to use WebSocket
      };
    };
    virtualHosts."vm4.serva.ketamin.trade" = {
      enableACME = true;
      forceSSL = true;
      extraConfig = ''
        allow 130.83.0.0/16; # TU-Darmstadt | AS8365
        allow 82.195.64.0/19; # Man-da | AS8365
        deny all;
      '';
      locations."/" = {
        proxyPass = "http://10.10.1.22:6904";
        proxyWebsockets = true; # needed if you need to use WebSocket
      };
    };
    virtualHosts."ai.ketamin.trade" = {
      enableACME = true;
      forceSSL = true;
      locations."/" = {
        proxyPass = "http://localhost:2315";
        proxyWebsockets = true; # needed if you need to use WebSocket
      };
    };
    virtualHosts."jellyfin.ketamin.trade" = {
      enableACME = true;
      forceSSL = true;
      locations."/" = {
        proxyPass = "http://localhost:8096";
        proxyWebsockets = true; # needed if you need to use WebSocket
      };
    };
    virtualHosts."jellyfin.dn42.ketamin.trade" = {
      enableACME = false;
      forceSSL = false;
      locations."/" = {
        proxyPass = "http://localhost:8096";
        proxyWebsockets = true; # needed if you need to use WebSocket
      };
    };
    virtualHosts."lg.ketamin.trade" = {
      enableACME = true;
      forceSSL = true;
      locations."/" = {
        proxyPass = "http://[::1]:15000";
        proxyWebsockets = true; # needed if you need to use WebSocket
      };
    };
    virtualHosts."ketamin.trade" = {
      enableACME = true;
      forceSSL = true;
      locations."/" = {
        return = "302 https://blog.ketamin.trade";
      };
    };
    virtualHosts.${config.services.nextcloud.hostName} = {
      forceSSL = true;
      enableACME = true;
    };
  };

  security.acme = {
    acceptTerms = true;
    defaults.email = "acme@ketamin.trade";
  };
}
