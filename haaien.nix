{ config, lib, ... }:

{
  systemd.network = {
    netdevs = {
      "haaien_dn42" = {
        netdevConfig = {
          Kind = "wireguard";
          Name = "haaien_dn42";
          MTUBytes = "1420";
        };
        wireguardConfig = {
          PrivateKeyFile = config.age.secrets.wg.path;
        };
        wireguardPeers = [
          {
            PublicKey = "EsLAjyP7oYoPqMDO0nmfC3DxpyER+7yPFBaGIntr0lA=";
            AllowedIPs = [
              "::/0"
              #             "0.0.0.0/0"
            ];
            Endpoint = "37.120.168.131:42422";
            PersistentKeepalive = 25;
          }
        ];
      };
    };
    networks.haaien_dn42 = {
      matchConfig.Name = "haaien_dn42";
      address = [ "fe80::1312/64" ];
      routes = [
        {
          Destination = "fe80::497a/64";
          Scope = "link";
        }
      ];
      networkConfig = {
        #        IPv4Forwarding = true;
        IPv6Forwarding = true;
      };
    };
  };

  services.bird2 = {
    config = lib.mkAfter ''
            protocol bgp haaien_dn42 from dnpeers {
                neighbor fe80::497a%haaien_dn42 as 4242420575;
      #          direct;
            }
    '';
  };
}
