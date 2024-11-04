{ ... }:
{
  services.grafana = {
    enable = true;
    settings = {
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
  services.prometheus = {
    scrapeConfigs = [
      {
        job_name = "nodes";
        scrape_interval = "30s";
        static_configs = [
          {
            targets = [
              "10.10.1.25:9100"
              "vps.ketamin.trade:9100"
              "vps2.ketamin.trade:9100"
              "shit.ketamin.trade:9100"
              "localhost:9100"
              "localhost:9753"
              "localhost:9633"
              "vps3.ketamin.trade:9100"
              "vps4.ketamin.trade:9100"
              "vps1.ketamin.trade:9100"
              "vps5.ketamin.trade:9100"
              "vps6.ketamin.trade:9100"
              "vps7.ketamin.trade:9100"
              "vps8.ketamin.trade:9100"
              "vps9.ketamin.trade:9100"
              "vps10.ketamin.trade:9100"
              "vps11.ketamin.trade:9100"
              "vps12.ketamin.trade:9100"
              "10.10.1.22:17871"
              "localhost:9708"
              "localhost:${config.services.prometheus.exporters.exportarr-sonarr.port}"
              "localhost:${config.services.prometheus.exporters.exportarr-radarr.port}"
              "localhost:${config.services.prometheus.exporters.exportarr-prowlarr.port}"
              "localhost:${config.services.prometheus.exporters.exportarr-bazarr.port}"
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
        refreshInterval = 1800;
        user = "prometheus";
        enable = true;
        repository = "rclone:smb:/Buro/backup";
        passwordFile = "/home/marie/restic";
        rcloneConfigFile = "/srv/pass";
      };
      smartctl = {
        enable = true;
        devices = [
          "/dev/sda"
          "/dev/sdb"
        ];
      };
     exportarr-prowlarr = {
     enable = true;
     port = 51231;
     apiKeyFile = "/home/marie/secrets/prowlarr";
     };
     exportarr-lidarr = {
     enable = true;
     port = 56231;
     apiKeyFile = "/home/marie/secrets/lidarr";
     };
     exportarr-sonarr = {
     enable = true;
     port = 51211;
     apiKeyFile = "/home/marie/secrets/sonarr";
     };
     exportarr-bazarr = {
     enable = true;
     port = 51235;
     apiKeyFile = "/home/marie/secrets/bazarr";
     };
    };
  };
}
