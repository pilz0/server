{ config, lib, ... }:

{
  systemd.network = {
    netdevs = {
      "dn42_lare" = {
        netdevConfig = {
          Kind = "wireguard";
          Name = "dn42_lare";
          MTUBytes = "1420";
        };
        wireguardConfig = {
          PrivateKeyFile = config.age.secrets.wg.path;
        };
        wireguardPeers = [
          {
            PublicKey = "dwtxXvpgWCGtX/QKFDaLXsWYRPd08Tg1JGsvzLudgjw=";
            AllowedIPs = [
              "::/0"
              "0.0.0.0/0"

            ];
            Endpoint = "de02.dn42.lare.cc:20663";
            PersistentKeepalive = 25;
          }
        ];
      };
    };
    networks.dn42_lare = {
      matchConfig.Name = "dn42_lare";
      address = [ "fe80::1312/64" ];
      routes = [
        {
          Destination = "fe80::3035:131/64";
          Scope = "link";
        }
      ];
      networkConfig = {
        IPv4Forwarding = true;
        IPv6Forwarding = true;
      };
    };
  };

  services.bird2 = {
    config = lib.mkAfter ''
      protocol bgp dn42_lare from dnpeers {
          neighbor fe80::3035:131%dn42_lare as 4242423035;
      }
    '';
  };
}
