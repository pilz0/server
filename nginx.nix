{ config, ... }:
{
  security.acme = {
    acceptTerms = true;
    defaults.email = "acme@ketamin.trade";
  };
  services.nginx = {
    enable = true;
    recommendedGzipSettings = true;
    recommendedOptimisation = true;
    recommendedProxySettings = true;
    recommendedTlsSettings = true;
    ## Other Zones
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
    virtualHosts."grafana.ketamin.trade" = {
      enableACME = true;
      forceSSL = true;
      locations."/" = {
        return = "302 https://grafana.pilz.foo";
      };
    };
    virtualHosts.${config.services.nextcloud.hostName} = {
      forceSSL = true;
      enableACME = true;
    };
    virtualHosts.${config.services.grafana.settings.server.domain} = {
      enableACME = true;
      forceSSL = true;
      locations."/" = {
        proxyPass = "http://localhost:3001";
        proxyWebsockets = true; # needed if you need to use WebSocket
      };
    };

    ## Zone ketamin.trade
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
    virtualHosts."readarr.ketamin.trade" = {
      enableACME = true;
      forceSSL = true;
      locations."/" = {
        proxyPass = "http://localhost:8787";
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
    ## Zone pilz.foo
    virtualHosts."routerlab1.pilz.foo" = {
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
    virtualHosts."routerlab1.dn42.pilz.foo" = {
      enableACME = false;
      forceSSL = false;
      basicAuth = {
        foo = "foo";
      };
      locations."/" = {
        proxyPass = "http://10.10.1.22:9001";
        proxyWebsockets = true; # needed if you need to use WebSocket
      };
    };
    virtualHosts."routerlab2.pilz.foo" = {
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
    virtualHosts."routerlab2.dn42.pilz.foo" = {
      enableACME = false;
      forceSSL = false;
      basicAuth = {
        foo = "foo";
      };
      locations."/" = {
        proxyPass = "http://10.10.1.22:9002";
        proxyWebsockets = true; # needed if you need to use WebSocket
      };
    };
    virtualHosts."routerlab3.pilz.foo" = {
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
    virtualHosts."routerlab3.dn42.pilz.foo" = {
      enableACME = false;
      forceSSL = false;
      basicAuth = {
        foo = "foo";
      };
      locations."/" = {
        proxyPass = "http://10.10.1.22:9003";
        proxyWebsockets = true; # needed if you need to use WebSocket
      };
    };
    virtualHosts."routerlab4.pilz.foo" = {
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
    virtualHosts."routerlab4.dn42.pilz.foo" = {
      enableACME = false;
      forceSSL = false;
      basicAuth = {
        foo = "foo";
      };
      locations."/" = {
        proxyPass = "http://10.10.1.22:9004";
        proxyWebsockets = true; # needed if you need to use WebSocket
      };
    };
    virtualHosts."routerlab5.pilz.foo" = {
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
    virtualHosts."routerlab5.dn42.pilz.foo" = {
      enableACME = false;
      forceSSL = false;
      basicAuth = {
        foo = "foo";
      };
      locations."/" = {
        proxyPass = "http://10.10.1.22:9005";
        proxyWebsockets = true; # needed if you need to use WebSocket
      };
    };
    virtualHosts."unifi.pilz.foo" = {
      enableACME = true;
      forceSSL = true;
      locations."/" = {
        proxyPass = "http://localhost:8443";
        proxyWebsockets = true; # needed if you need to use WebSocket
      };
    };
    virtualHosts."unifi.dn42.pilz.foo" = {
      enableACME = false;
      forceSSL = false;
      locations."/" = {
        proxyPass = "http://localhost:8443";
        proxyWebsockets = true; # needed if you need to use WebSocket
      };
    };
    virtualHosts."radarr.pilz.foo" = {
      enableACME = true;
      forceSSL = true;
      locations."/" = {
        proxyPass = "http://localhost:7878";
        proxyWebsockets = true; # needed if you need to use WebSocket
      };
    };
    virtualHosts."radarr.dn42.pilz.foo" = {
      enableACME = false;
      forceSSL = false;
      locations."/" = {
        proxyPass = "http://localhost:7878";
        proxyWebsockets = true; # needed if you need to use WebSocket
      };
    };
    virtualHosts."bazarr.pilz.foo" = {
      enableACME = true;
      forceSSL = true;
      locations."/" = {
        proxyPass = "http://localhost:6767";
        proxyWebsockets = true; # needed if you need to use WebSocket
      };
    };
    virtualHosts."bazarr.dn42.pilz.foo" = {
      enableACME = false;
      forceSSL = false;
      locations."/" = {
        proxyPass = "http://localhost:6767";
        proxyWebsockets = true; # needed if you need to use WebSocket
      };
    };
    virtualHosts."sonarr.pilz.foo" = {
      enableACME = true;
      forceSSL = true;
      locations."/" = {
        proxyPass = "http://localhost:8989";
        proxyWebsockets = true; # needed if you need to use WebSocket
      };
    };
    virtualHosts."sonarr.dn42.pilz.foo" = {
      enableACME = false;
      forceSSL = false;
      locations."/" = {
        proxyPass = "http://localhost:8989";
        proxyWebsockets = true; # needed if you need to use WebSocket
      };
    };
    virtualHosts."prowlarr.pilz.foo" = {
      enableACME = true;
      forceSSL = true;
      locations."/" = {
        proxyPass = "http://localhost:9696";
        proxyWebsockets = true; # needed if you need to use WebSocket
      };
    };
    virtualHosts."prowlarr.dn42.pilz.foo" = {
      enableACME = false;
      forceSSL = false;
      locations."/" = {
        proxyPass = "http://localhost:9696";
        proxyWebsockets = true; # needed if you need to use WebSocket
      };
    };
    virtualHosts."readarr.pilz.foo" = {
      enableACME = true;
      forceSSL = true;
      locations."/" = {
        proxyPass = "http://localhost:8787";
        proxyWebsockets = true; # needed if you need to use WebSocket
      };
    };
    virtualHosts."readarr.dn42.pilz.foo" = {
      enableACME = false;
      forceSSL = false;
      locations."/" = {
        proxyPass = "http://localhost:8787";
        proxyWebsockets = true; # needed if you need to use WebSocket
      };
    };
    virtualHosts."lidarr.pilz.foo" = {
      enableACME = true;
      forceSSL = true;
      locations."/" = {
        proxyPass = "http://localhost:8686";
        proxyWebsockets = true; # needed if you need to use WebSocket
      };
    };
    virtualHosts."lidarr.dn42.pilz.foo" = {
      enableACME = false;
      forceSSL = false;
      locations."/" = {
        proxyPass = "http://localhost:8686";
        proxyWebsockets = true; # needed if you need to use WebSocket
      };
    };
    virtualHosts."jellyseerr.pilz.foo" = {
      enableACME = true;
      forceSSL = true;
      locations."/" = {
        proxyPass = "http://localhost:5055";
        proxyWebsockets = true; # needed if you need to use WebSocket
      };
    };
    virtualHosts."jellyseerr.dn42.pilz.foo" = {
      enableACME = false;
      forceSSL = false;
      locations."/" = {
        proxyPass = "http://localhost:5055";
        proxyWebsockets = true; # needed if you need to use WebSocket
      };
    };
    virtualHosts."torrent.pilz.foo" = {
      enableACME = true;
      forceSSL = true;
      locations."/" = {
        proxyPass = "http://10.10.1.22:8090";
        proxyWebsockets = true; # needed if you need to use WebSocket
      };
    };
    virtualHosts."torrent.dn42.pilz.foo" = {
      enableACME = false;
      forceSSL = false;
      locations."/" = {
        proxyPass = "http://10.10.1.22:8090";
        proxyWebsockets = true; # needed if you need to use WebSocket
      };
    };
    virtualHosts."vm1.serva.pilz.foo" = {
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
    virtualHosts."vm1.serva.dn42.pilz.foo" = {
      enableACME = false;
      forceSSL = false;
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
    virtualHosts."vm2.serva.pilz.foo" = {
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
    virtualHosts."vm2.serva.dn42.pilz.foo" = {
      enableACME = false;
      forceSSL = false;
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
    virtualHosts."vm3.serva.pilz.foo" = {
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
    virtualHosts."vm3.serva.dn42.pilz.foo" = {
      enableACME = false;
      forceSSL = false;
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
    virtualHosts."vm4.serva.pilz.foo" = {
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
    virtualHosts."vm4.serva.dn42.pilz.foo" = {
      enableACME = false;
      forceSSL = false;
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
    virtualHosts."ai.pilz.foo" = {
      enableACME = true;
      forceSSL = true;
      locations."/" = {
        proxyPass = "http://localhost:2315";
        proxyWebsockets = true; # needed if you need to use WebSocket
      };
    };
    virtualHosts."ai.dn42.pilz.foo" = {
      enableACME = false;
      forceSSL = false;
      locations."/" = {
        proxyPass = "http://localhost:2315";
        proxyWebsockets = true; # needed if you need to use WebSocket
      };
    };
    virtualHosts."jellyfin.pilz.foo" = {
      enableACME = true;
      forceSSL = true;
      locations."/" = {
        proxyPass = "http://localhost:8096";
        proxyWebsockets = true; # needed if you need to use WebSocket
      };
    };
    virtualHosts."jellyfin.dn42.pilz.foo" = {
      enableACME = false;
      forceSSL = false;
      locations."/" = {
        proxyPass = "http://localhost:8096";
        proxyWebsockets = true; # needed if you need to use WebSocket
      };
    };
    virtualHosts."lg.pilz.foo" = {
      enableACME = true;
      forceSSL = true;
      locations."/" = {
        proxyPass = "http://[::1]:15000";
        proxyWebsockets = true; # needed if you need to use WebSocket
      };
    };
    virtualHosts."lg.dn42.pilz.foo" = {
      locations."/" = {
        proxyPass = "http://[::1]:15000";
        proxyWebsockets = true; # needed if you need to use WebSocket
      };
    };
    virtualHosts."pilz.foo" = {
      enableACME = true;
      forceSSL = true;
      locations."/" = {
        return = "302 https://blog.pilz.foo";
      };
    };
  };
}
