{ config, ... }:
{
  services.restic.backups = {
    smb = {
      user = "root";
      repository = "rclone:smb:/Buro/backup";
      initialize = true; # initializes the repo, don't set if you want manual control
      passwordFile = config.age.secrets.restic.path;
      paths = [
        "/home/marie"
        "/srv"
      ];
      timerConfig = {
        onCalendar = "sunday 11:00";
      };
    };
  };
}
