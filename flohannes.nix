{ ... }:

{
  services.listmonk = {
    enable = true;
    settings = {
      app = {
        address = "[::1]:61015";
        admin_username = "listmonk";
      };

      db = {
        host = "/run/postgresql";
        port = 5432;
        user = "listmonk";
        database = "listmonk";
      };
    };
    secretFile = "/home/marie/.listmonk";
  };

  environment.persistence."/persist".directories = [ "/var/lib/private/listmonk" ];

  services.postgresql = {
    ensureUsers = [
      {
        name = "listmonk";
        ensureDBOwnership = true;
      }
    ];
    ensureDatabases = [ "listmonk" ];
  };
services.wordpress.sites."flohannes.de" = {
    languages = [ pkgs.wordpressPackages.languages.de_DE ];
  themes = {
    inherit (pkgs.wordpressPackages.themes)
      twentytwentythree;
  };
  plugins = {
    inherit (pkgs.wordpressPackages.plugins) 
      antispam-bee
      opengraph;
      wordpress-seo;
      jetpack;
  };
settings = {
    WP_DEFAULT_THEME = "responsive";
    FORCE_SSL_ADMIN = true;
    WPLANG = "de_DE";
  };
  extraConfig = ''
    $_SERVER['HTTPS']='on';
  '';
  virtualHosts.listen."flohannes.de".port = 3235;
};
}
