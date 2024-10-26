{ pkgs, config, ... }:
{
  services.nginx = {
    enable = true;
    recommendedGzipSettings = true;
    recommendedOptimisation = true;
    recommendedProxySettings = true;
    recommendedTlsSettings = true;
    # other Nginx options
    virtualHosts."grafana.ketamin.trade" = {
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
        proxyPass = "https://localhost:8443";
        proxyWebsockets = true; # needed if you need to use WebSocket
      };
    };
    virtualHosts."lists.ketamin.trade" = {
      enableACME = true;
      forceSSL = true;
      locations."/" = {
        proxyPass = "https://localhost:61015";
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
    virtualHosts."ai.ketamin.trade" = {
      enableACME = true;
      forceSSL = true;
      locations."/" = {
        proxyPass = "http://localhost:2315";
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
