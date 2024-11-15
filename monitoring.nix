{ pkgs, config, ... }:
{
  age.secrets.rclone = {
    file = ./secrets/rclone.age;
    owner = "prometheus";
    group = "prometheus";
  };
  age.secrets.restic = {
    file = ./secrets/restic.age;
    owner = "prometheus";
    group = "prometheus";
  };
  age.secrets.smtp = {
    file = ./secrets/smtp.age;
    owner = "grafana";
    group = "grafana";
  };

  services.grafana = {
    enable = true;
    declarativePlugins = with pkgs.grafanaPlugins; [
      grafana-github-datasource
      grafana-clock-panel
      grafana-oncall-app
      grafana-piechart-panel
    ];
    provision = {
      enable = true;
      datasources.settings.datasources = [
        {
          type = "prometheus";
          isDefault = true;
          name = "prometheus";
          url = "http://localhost:1312";
          uid = "e68e5107-0b44-4438-870c-019649e85d2b";
        }
      ];
      dashboards = {
        settings = {
          providers = [
            {
              name = "My Dashboards";
              options.path = "/etc/grafana-dashboards";
            }
          ];
        };
      };

    };

    settings = {
      analytics.reporting_enabled = false;
      smtp = {
        enable = true;
        enabled = true;
        user = "t3st1ng1312@cock.li";
        startTLS_policy = "MandatoryStartTLS";
        password = builtins.readFile config.age.secrets.smtp.path;
        host = "mail.cock.li:465";
        from_name = config.services.grafana.settings.server.domain;
        from_address = config.services.grafana.settings.smtp.user;
      };
      server = {
        domain = "grafana.ketamin.trade";
        http_port = 3001;
        http_addr = "::1";
      };
      "auth.anonymous" = {
        enabled = true;
        org_name = "Main Org.";
        org_role = "Viewer";
      };
    };
  };
  environment.etc = {
    "grafana-dashboards/node-exporter.json" = {
      source = ./grafana-dashboards/node-exporter.json;
      group = "grafana";
      user = "grafana";
    };
    "grafana-dashboards/restic.json" = {
      source = ./grafana-dashboards/restic.json;
      group = "grafana";
      user = "grafana";
    };
    "grafana-dashboards/tor.json" = {
      source = ./grafana-dashboards/tor.json;
      group = "grafana";
      user = "grafana";
    };
    "grafana-dashboards/qbittorrent.json" = {
      source = ./grafana-dashboards/qbittorrent.json;
      group = "grafana";
      user = "grafana";
    };
    "grafana-dashboards/smartctl.json" = {
      source = ./grafana-dashboards/smartctl.json;
      group = "grafana";
      user = "grafana";
    };
  };
  services.prometheus = {
    scrapeConfigs = [
      {
        job_name = "nodes";
        scrape_interval = "30s";
        static_configs = [
          {
            targets = [
              "10.10.1.25:9100"
              "10.10.1.22:17871"
              "shit.ketamin.trade:9100"
              "localhost:9100"
              "localhost:9753"
              "localhost:9633"
              "localhost:9708"
              "localhost:56231"
              "localhost:51711"
              "localhost:51235"
              "localhost:51211"
              "localhost:51231"
              "tor1.ketamin.trade:9100"
              "tor2.ketamin.trade:9100"
            ];

          }
        ];
      }
      {
        job_name = "unifi";
        scrape_interval = "30s";
        static_configs = [
          {
            targets = [ "localhost:9130" ];

          }
        ];
      }
    ];
    enable = true;
    port = 1312;
    exporters = {
      node = {
        enable = true;
        enabledCollectors = [ "systemd" ];
        port = 9100;
      };
      restic = {
        refreshInterval = 6000;
        user = "prometheus";
        enable = true;
        repository = "rclone:smb:/Buro/backup";
        passwordFile = config.age.secrets.restic.path;
        rcloneConfigFile = config.age.secrets.rclone.path;
      };
      smartctl = {
        enable = true;
        devices = [
          "/dev/sda"
          "/dev/sdb"
        ];
      };
      #      exportarr-prowlarr = {
      #        enable = true;
      #        port = 51231;
      #        apiKeyFile = "/var/lib/secrets/prowlarr";
      #        user = "prometheus";
      #        url = config.services.nginx.virtualHosts."prowlarr.ketamin.trade".locations."/".proxyPass;
      #        extraFlags = [ "-c /var/lib/prowlarr/config.xml" ];
      #      };
      #      exportarr-lidarr = {
      #        enable = true;
      #        port = 56231;
      #        apiKeyFile = "/var/lib/secrets/lidarr";
      #        user = "prometheus";
      #        url = config.services.nginx.virtualHosts."lidarr.ketamin.trade".locations."/".proxyPass;
      #        extraFlags = [ "--api-key-file /var/lib/secrets/lidarr" ];
      #      };
      #      exportarr-sonarr = {
      #        enable = true;
      #        port = 51211;
      #        apiKeyFile = "/var/lib/secrets/sonarr";
      #        user = "prometheus";
      #        url = config.services.nginx.virtualHosts."sonarr.ketamin.trade".locations."/".proxyPass;
      #        extraFlags = [ "--api-key-file /var/lib/secrets/sonarr" ];
      #      };
      #      exportarr-radarr = {
      #        enable = true;
      #        port = 51711;
      #        user = "prometheus";
      #        url = config.services.nginx.virtualHosts."radarr.ketamin.trade".locations."/".proxyPass;
      #        extraFlags = [ (builtins.readFile /var/lib/secrets/bazarr) ];
      #      };
      #      exportarr-bazarr = {
      #        enable = true;
      #        port = 51235;
      #        user = "prometheus";
      #        url = config.services.nginx.virtualHosts."bazarr.ketamin.trade".locations."/".proxyPass;
      #        apiKeyFile = "/var/lib/secrets/bazarr";
      #	extraFlags = [ (builtins.readFile /var/lib/secrets/bazarr) ];
      #      };
    };
  };
}
