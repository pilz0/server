{ pkgs, ... }:
{
  services.wordpress.sites."localhost" = {
    languages = [ pkgs.wordpressPackages.languages.de_DE ];
    settings = {
      WPLANG = "de_DE";
      FORCE_SSL_ADMIN = true;
    };
    extraConfig = ''
      $_SERVER['HTTPS']='on';
    '';
  };

}
