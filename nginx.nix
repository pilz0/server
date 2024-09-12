{ ... }:
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
        proxyPass = "http://10.10.1.9:1100";
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
  };
  security.acme = {
    acceptTerms = true;
    defaults.email = "acme@ketamin.trade";
  };
}
