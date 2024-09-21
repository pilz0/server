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
        scrape_interval = "2s";
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
              "10.10.1.9:17871"
            ];

          }
        ];
      }
      {
        job_name = "unifi";
        scrape_interval = "2s";
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
        passwordFile = "/home/marie/restic/password";
        rcloneConfigFile = "/srv/pass";
      };
      smartctl = {
        enable = true;
        devices = [
          "/dev/sda"
          "/dev/sdb"
        ];
      };
    };
  };
}
