{
  config,
  ...
}:
{
  age.secrets.mailpw = {
    file = ./secrets/smtp.age;
    owner = "mastodon";
    group = "mastodon";
  };
  age.secrets.writefreely = {
    file = ./secrets/writefreely.age;
    owner = "writefreely";
    group = "writefreely";
  };

  virtualisation.docker.enable = true;
  virtualisation.containerd.enable = true;
  services.tailscale.enable = true;
  programs.git.config.user.name = "pilz0";
  programs.git.config.user.email = "marie0@riseup.net";

  #    services.ollama = {
  #      enable = true;
  #      acceleration = "cuda";
  #      loadModels = [ "llama3.2" ];
  #    };
  #    services.open-webui = {
  #      enable = true;
  #      port = 2315;
  #    };

  services.writefreely = {
    enable = true;
    admin = {
      name = "marie";
      initialPasswordFile = config.age.secrets.writefreely.path;
    };
    group = "writefreely";
    user = "writefreely";
    settings.app.theme = "Painkiller Bullet";
    host = "flohannes.de";
    database = {
      type = "sqlite3";
    };
    nginx = {
      enable = true;
      forceSSL = true;
    };
    acme = {
      enable = true;
    };
  };
  services.mastodon = {
    enable = true;
    localDomain = "m.ketamin.trade"; # Replace with your own domain
    configureNginx = true;
    smtp = {
      fromAddress = "t3st1ng1312@cock.li"; # Email address used by Mastodon to send emails, replace with your own
      user = "t3st1ng1312@cock.li";
      passwordFile = config.age.secrets.mailpw.path;
      host = "mail.cock.li";
      authenticate = true;
      createLocally = false;
      port = 465;
    };
    streamingProcesses = 2; # Number of processes used by the mastodon-streaming service. recommended is the amount of your CPU cores minus one.
  };
  services.postgresqlBackup = {
    enable = true;
    databases = [
      "mastodon"
      "nextcloud"
    ];
  };
}
