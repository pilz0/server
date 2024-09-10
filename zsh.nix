{ pkgs, ... }:
{
  programs.zsh.enable = true;
  programs.zsh.ohMyZsh.enable = true;
  programs.zsh.ohMyZsh.theme = "crunch";
  programs.zsh.autosuggestions.enable = true;
  programs.zsh.shellAliases = {
    backup = "restic -r rclone:smb:/Buro/backup backup -p /home/marie/restic/password --verbose /home /var/lib/docker /srv";
  };
  programs.zsh.shellAliases = {
    update = "sudo nix flake update /home/marie/server";
  };
  programs.zsh.shellAliases = {
    rebuild = "sudo nixos-rebuild --flake /home/marie/server switch";
  };
  users.defaultUserShell = pkgs.zsh;
}
