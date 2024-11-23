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
            Endpoint = "hortorum.neverstable.net:42422";
            PersistentKeepalive = 25;
          }
        ];
      };
    };
    networks.haaien_dn42 = {
      matchConfig.Name = "haaien_dn42";
      address = [ "fe80::1312/128" ];
      routes = [
        {
          Destination = "fe80::acab/128";
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
      protocol bgp HAAIEN_DN42 from dnpeers {
          neighbor fe80::acab%haaien_dn42 as 4242420575;
          direct;
      }
    '';
  };
}
