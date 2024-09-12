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
    secretFile = "/home/marie/.listmonk.toml";
    # TODO set settings immutably via database.settings
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
}
