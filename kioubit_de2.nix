# Establishes wireguard tunnels with all nodes with static IPs as hubs.
{ config, lib, ... }:

{
  systemd.network = {
    netdevs = {
      "50-kioubit_de2" = {
        netdevConfig = {
          Kind = "wireguard";
          Name = "kioubit_de2";
          MTUBytes = "1420";
        };
        wireguardConfig = {
          PrivateKeyFile = config.age.secrets.wg.path;
        };
        wireguardPeers = [
          {
            PublicKey = "B1xSG/XTJRLd+GrWDsB06BqnIq8Xud93YVh/LYYYtUY=";
            AllowedIPs = [
              "::/0"
              "0.0.0.0/0"
            ];
            Endpoint = "116.203.141.239:20663";
            PersistentKeepalive = 25;
          }
        ];
      };
    };
    networks.kioubit_de2 = {
      matchConfig.Name = "kioubit_de2";
      address = [ "fe80::ade1/64" ];
      routes = [
        {
          Destination = "fe80::ade0/64";
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
      protocol bgp kioubit_de2 from dnpeers {
          neighbor fe80::ade0%kioubit_de2 as 4242423914;
      }
    '';
  };
}
