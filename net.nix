{ pkgs, ... }:
{
  # services.unifi = {
  #   enable = true;
  # openFirewall = true;
  #  unifiPackage = pkgs.unifi8;
  # };

  #services.unifi.mongodbPackage = pkgs.mongodb-7_0;
  networking.networkmanager.enable = true;
  networking.nameservers = [
    "::1"
    "127.0.0.1"
    "1.1.1.1"
  ];
  networking.hostName = "serva";
  networking.extraHosts = ''
    127.0.0.1 cloud.ketamin.trade
    172.22.179.129 serva.lg.ketamin.trade
    127.0.0.1 cloud.pilz.foo
    172.22.179.129 serva.lg.pilz.foo
  '';
  services.unpoller = {
    #   enable = true;
    influxdb.disable = true;
    unifi = {
      defaults = {
        url = "https://localhost:8443";
        user = "unpoller";
        pass = "/srv/password";
        verify_ssl = false;
      };
    };
  };

  services.unbound = {
    enable = true;
    settings = {
      server = {
        local-zone = [
          "20.172.in-addr.arpa. nodefault"
          "21.172.in-addr.arpa. nodefault"
          "22.172.in-addr.arpa. nodefault"
          "23.172.in-addr.arpa. nodefault"
          "10.in-addr.arpa. nodefault"
          "d.f.ip6.arpa. nodefault"
        ];
        interface = [
          "0.0.0.0/0"
          "::/0"
        ];
        port = 53;
        access-control = [
          "0.0.0.0/0 allow"
          "::1/0 allow"
        ];
        # Based on recommended settings in https://docs.pi-hole.net/guides/dns/unbound/#configure-unbound
        harden-glue = true;
        harden-dnssec-stripped = true;
        use-caps-for-id = false;
        prefetch = true;
        edns-buffer-size = 1232;
      };
      forward-zone = [
        {
          name = "dn42";
          forward-addr = [
            "fd42:d42:d42:54::1"
            "172.20.0.53"
          ];
        }
        {
          name = "20.172.in-addr.arpa";
          forward-addr = [
            "fd42:d42:d42:54::1"
            "172.20.0.53"
          ];
        }
        {
          name = "21.172.in-addr.arpa";
          forward-addr = [
            "fd42:d42:d42:54::1"
            "172.20.0.53"
          ];
        }
        {
          name = "22.172.in-addr.arpa";
          forward-addr = [
            "fd42:d42:d42:54::1"
            "172.20.0.53"
          ];
        }
        {
          name = "23.172.in-addr.arpa";
          forward-addr = [
            "fd42:d42:d42:54::1"
            "172.20.0.53"
          ];
        }
        {
          name = "10.in-addr.arpa";
          forward-addr = [
            "fd42:d42:d42:54::1"
            "172.20.0.53"
          ];
        }
        {
          name = "d.f.ip6.arpa";
          forward-addr = [
            "fd42:d42:d42:54::1"
            "172.20.0.53"
          ];
        }
        {
          name = ".";
          forward-addr = [
            "2606:4700:4700::1111#cloudflare-dns.com"
            "2620:fe::fe#dns.quad9.net"
            "1.1.1.1#cloudflare-dns.com"
            "9.9.9.9#dns.quad9.net"
          ];
          forward-tls-upstream = true; # Protected DNS
        }
      ];
    };
  };

  networking.firewall = {
    allowedTCPPorts = [
      22 # ssh
      80 # http
      443 # https
      179 # bgp
      1100 # nextcloud-docker
      9001 # routerlab
      9002 # routerlab
      9003 # routerlab
      9004 # routerlab
      9005 # routerlab
      6901 # linuxvm
      6902 # linuxvm
      6903 # linuxvm
      6904 # linuxvm
    ];
    allowedUDPPorts = [
      22 # ssh
      80 # http
      443 # https
      179 # bgp
      1100 # nextcloud-docker
      9001 # routerlab
      9002 # routerlab
      9003 # routerlab
      9004 # routerlab
      9005 # routerlab
      6901 # linuxvm
      6902 # linuxvm
      6903 # linuxvm
      6904 # linuxvm
    ];
  };
}
