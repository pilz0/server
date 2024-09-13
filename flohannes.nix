{ pkgs, lib, ... }:

let
  wordpressPackage = pkgs.unstable.wordpress;  # use unstable to stay closer to upstream

    "flohannes.de" = {
      shortName = "flohannes";
      port = 61020;
    };
  };

  # external plugin packages not available in nipxkgs
  plugins = {
  languages = [
    (pkgs.stdenv.mkDerivation rec {
      pname = "wordpress-language-de_DE";
      version = wordpressPackage.version;
      src = pkgs.fetchurl {
        # name is required to invalidate the hash when wordpress is updated, see option example
        name = "${pname}-${version}.tar.gz";
        url = "https://de.wordpress.org/wordpress-${wordpressPackage.version}-de_DE.tar.gz";
        sha256 = "sha256-9/PKxyGBOfHHlix5jfDeSt+4LYh8Ip+hR3EWQ0KNZs8=";
      };
      installPhase = "pwd; mkdir -p $out; cp -r ./wp-content/languages/* $out/";
    })
  ];

in {
  services.wordpress = {
    webserver = "nginx";
    sites = lib.mkMerge [

      (lib.attrsets.mapAttrs' (site: cfg: (
        lib.attrsets.nameValuePair site {
          package = wordpressPackage;
          inherit languages;
          settings = let
            url = if cfg.www or false
              then "https://www.${site}"
              else "https://${site}";
          in {
            WP_SITEURL = url;
            WP_HOME = url;
            WPLANG = "de_DE";
            FORCE_SSL_ADMIN = true;
            DISALLOW_FILE_MODS = true;  # disables the plugin/theme installer and all file changes
          };
        }
      )) sites)

      {
        "flogannes.de" = {
          themes = { inherit (pkgs.wordpressPackages.themes) twentytwenty; };
          plugins = { inherit (plugins)
          ;};
          settings = {
            WP_DEFAULT_THEME = "twentytwenty";
          };
        };
      }
    ];
  };

  services.phpfpm.pools = lib.attrsets.mapAttrs' (site: cfg: (
    lib.attrsets.nameValuePair "wordpress-${site}" {
      phpPackage = pkgs.php.withExtensions ({ enabled, all }: enabled ++ [ all.imagick ]);
      phpOptions = ''
        memory_limit = 64M
        max_execution_time = 600
        file_uploads = On
        upload_max_filesize = 200M
        post_max_size = 800M
      '';
    }
  )) sites;

  services.nginx.virtualHosts = lib.attrsets.mapAttrs' (site: cfg: (
    lib.attrsets.nameValuePair site {
      enableACME = true;
      forceSSL = true;
      listen = lib.mkForce [ { addr = "[::1]"; port = cfg.port; } ];
      extraConfig = ''
        set_real_ip_from ::1;
        real_ip_header X-Forwarded-For;
      '';
      locations."~ \\.php$".extraConfig = ''
        fastcgi_param HTTPS 'on';
      '';
    }
  )) sites;
  
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
  
  services.postgresql = {
    ensureUsers = [
      {
        name = "listmonk";
        ensureDBOwnership = true;
      }
    ];
    ensureDatabases = [ "listmonk" ];
  };
