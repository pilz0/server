{ pkgs, ... }:
{
services.restic.backups = {
  smb = {
    user = "marie";
    repository = "rclone:smb:/Buro/backup";
    initialize = true; # initializes the repo, don't set if you want manual control
    passwordFile = "/home/marie/restic/password";
    paths = [ "/home/marie" "/srv" ];
    timerConfig = {
      onCalendar = "sunday 11:00";
   };
  };
};
}
