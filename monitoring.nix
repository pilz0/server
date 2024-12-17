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
  age.secrets.grafana = {
    file = ./secrets/grafana.age;
    owner = "grafana";
    group = "grafana";
  };
  age.secrets.nextcloud-exporter = {
    file = ./secrets/nextcloud-exporter.age;
    owner = "prometheus";
    group = "prometheus";
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
          url = "http://localhost:${toString config.services.prometheus.port}";
          uid = "e68e5107-0b44-4438-870c-019649e85d2b";
        }
        {
          name = "Loki";
          type = "loki";
          url = "http://127.0.0.1:4040";
          uid = "180d3e53-be75-4a6a-bb71-bdf437aec085";
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
        domain = "grafana.pilz.foo";
        http_port = 3001;
        http_addr = "::1";
      };
      "auth.anonymous" = {
        enabled = true;
        org_name = "Main Org.";
        org_role = "Viewer";
      };
      security = {
        admin_password = builtins.readFile config.age.secrets.grafana.path;
        admin_user = "admin";
        admin_email = "marie0@riseup.net";
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
    "grafana-dashboards/bird.json" = {
      source = ./grafana-dashboards/bird.json;
      group = "grafana";
      user = "grafana";
    };
    "grafana-dashboards/unpoller.json" = {
      source = ./grafana-dashboards/unpoller.json;
      group = "grafana";
      user = "grafana";
    };
    "grafana-dashboards/dn42.json" = {
      source = ./grafana-dashboards/dn42.json;
      group = "grafana";
      user = "grafana";
    };
    "grafana-dashboards/postgres.json" = {
      source = ./grafana-dashboards/postgres.json;
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
              "localhost:${toString config.services.prometheus.exporters.node.port}"
              "localhost:9753"
              "localhost:9633"
              "localhost:9708"
              "tor1.ketamin.trade:9100"
              "tor2.ketamin.trade:9100"
              "tor3.ketamin.trade:9100"
              "localhost:9205"
              "localhost:9324"
              "localhost:9121"
              "localhost:9187"
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
      bird = {
        enable = true;
      };
      postgres = {
        enable = true;
        port = 9187;
        runAsLocalSuperUser = true;
        extraFlags = [ "--auto-discover-databases" ];
      };
      redis = {
        enable = true;
        port = 9121;
        extraFlags = [ "--redis.addr=127.0.0.1:${toString config.services.mastodon.redis.port}" ];
      };
    };
  };
}
