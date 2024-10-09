{ pkgs, ... }:
{
  networking.wireguard.interfaces.dn42-peer1 = {
    privateKeyFile = "/home/marie/wg/privatekey";
    allowedIPsAsRoutes = false;
    listenPort = 20663;

    peers = [
      {
        publicKey = "B1xSG/XTJRLd+GrWDsB06BqnIq8Xud93YVh/LYYYtUY=";
        allowedIPs = [
          "0.0.0.0/0"
          "::/0"
        ];
        endpoint = "de2.g-load.eu:20663";
      }
    ];
    postSetup = ''
      ${pkgs.iproute}/bin/ip addr add 192.168.217.70/32 peer 172.20.53.97/32 dev dn42-peer
      ${pkgs.iproute}/bin/ip -6 addr add fe80::ade0/128 dev dn42-peer
    '';
  };
}
