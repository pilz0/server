let
#marieyubi = "sk-ssh-ed25519@openssh.com AAAAGnNrLXNzaC1lZDI1NTE5QG9wZW5zc2guY29tAAAAIBTGgUYUsIAtcbZBqk5Mq0LH2T5KGFjdjAgNIwUf+/LBAAAABHNzaDo= pilz@framewok";
#marietoken2 = "ecdsa-sha2-nistp256@openssh.com AAAAInNrLWVjZHNhLXNoYTItbmlzdHAyNTZAb3BlbnNzaC5jb20AAAAIbmlzdHAyNTYAAABBBAGgIgZKjLpJFdYK1+Ovd1IHQZhdCy2ZIz1Sf8qVGErkNVPkYOU3iJRoK2pJKrotZTo/2oTaSTzxewXKKJQ98toAAAAEc3NoOg== pilz@token2";
marieunderdesk = "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIP6weqYi/f7nQzsCr11NVz/7cdmpSq7sU1N+Ag5jM45S daniel@underdesk";
marie  = "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIHvFOnWA6pCKpekFoB1ZrAye7w2r+uJZHaKDiksSJqAX marie@serva";

users = [ marie marieunderdesk ];
serva = "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIOFNa2EBrRNnGMjGSNjlD1pXo9YRuq6rOsC3v+6VAg2F root@nixos";
systems = [ serva ];


in
{
  "nextcloud.age".publicKeys = [ marieunderdesk serva ];
  "rclone.age".publicKeys = [  marieunderdesk serva ];
  "restic.age".publicKeys = [  marieunderdesk serva ];
}
