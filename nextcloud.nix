{ config, pkgs, ... }:
{
age.secrets.nextcloud = {
  file = ./secrets/nextcloud.age;
  owner = "nextcloud";
  group = "nextcloud";
};
services.nextcloud = {
    enable = true;
    configureRedis = true;
    package = pkgs.nextcloud30;
    hostName = "cloud.ketamin.trade";
    appstoreEnable = true;
    autoUpdateApps.enable = true;
    database.createLocally = true;
    config = {
    adminpassFile = config.age.secrets.nextcloud.path;
    adminuser = "admin";
};
    settings = {
#    dbtype = "pgsql";
#    dbuser = "nextcloud";
#    dbhost = "/run/postgresql"; # nextcloud will add /.s.PGSQL.5432 by itself
#    dbname = "nextcloud";
    trustedProxies = [ "localhost" "127.0.0.1" "[::1]" "${config.services.nextcloud.hostName}" ];
    extraTrustedDomains = [ "${config.services.nextcloud.hostName}" ];
    overwriteProtocol = "https";
    };
};

#services.postgresql = {
#    enable = true;
#    ensureDatabases = [ "nextcloud" ];
#    ensureUsers = [
#    { name = "nextcloud";
#    ensureDBOwnership = true;
#    }
#    ];
#};

# ensure that postgres is running *before* running the setup
#systemd.services."nextcloud-setup" = {
#    requires = ["postgresql.service"];
#   after = ["postgresql.service"];
#};
}
