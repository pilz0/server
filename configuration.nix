
### Edit this configuration file to define what should be installed on
# your system.  Help is available in the configuration.nix(5) man page
# and in the NixOS manual (accessible by running ‘nixos-help’).

{ inputs, config, pkgs,lib, modules, ... }:

{
  imports = [
    # Include the results of the hardware scan.
    ./hardware-configuration.nix
  ];
  # Bootloader.
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;
  #Hostname
  networking.hostName = "serva";
  #Self doxx UwU
  time.timeZone = "Europe/Berlin";
  # Select internationalisation properties.
  i18n.defaultLocale = "de_DE.UTF-8";
  i18n.extraLocaleSettings = {
    LC_ADDRESS = "de_DE.UTF-8";
    LC_IDENTIFICATION = "de_DE.UTF-8";
    LC_MEASUREMENT = "de_DE.UTF-8";
    LC_MONETARY = "de_DE.UTF-8";
    LC_NAME = "de_DE.UTF-8";
    LC_NUMERIC = "de_DE.UTF-8";
    LC_PAPER = "de_DE.UTF-8";
    LC_TELEPHONE = "de_DE.UTF-8";
    LC_TIME = "de_DE.UTF-8";
  };
  console.keyMap = "de";
  hardware.pulseaudio.enable = false;
  security.rtkit.enable = true;
  services.pipewire = {
    enable = true;
    alsa.enable = true;
    alsa.support32Bit = true;
    pulse.enable = true;
  };
  #my user account
      users.users.marie.isNormalUser = true;
      users.users.marie.description = "marie";
      users.users.marie.extraGroups = [ "networkmanager" "wheel" ];
      users.users.marie.openssh.authorizedKeys.keys = ["sk-ssh-ed25519@openssh.com AAAAGnNrLXNzaC1lZDI1NTE5QG9wZW5zc2guY29tAAAAIBTGgUYUsIAtcbZBqk5Mq0LH2T5KGFjdjAgNIwUf+/LBAAAABHNzaDo= pilz@framewok" "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIP6weqYi/f7nQzsCr11NVz/7cdmpSq7sU1N+Ag5jM45S daniel@underdesk" ];

  # Jule
      users.users.pizzaladen.group = "pizzaladen";
      users.groups.pizzaladen = {};
      users.users.pizzaladen.isNormalUser = true;
      users.users.pizzaladen.description = "pizzaladen";
      users.users.pizzaladen.createHome = true;
      users.users.pizzaladen.home = "/home/pizzaladen";
      users.users.pizzaladen.openssh.authorizedKeys.keys = ["ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAINW02E19w2YUO7d82WDHyMqfyUdIDCgjblwPJvgc1wzF pizzaladen@pizzaladen-HP-EliteBook-840-G1" "ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAACAQC6VDJ9roxToSC8qT+zawLauEDWnC2+W/b/jw19Wiq+6ug+Ey725sxl62nMxI1INpUCkYUSbXlziWA1Ml0XT/jgDZ4CPbKq5yAoziY6UvXZkRDTuhXLn4UViUiEqn9Y2X9t5CtU7TON8vp7SIIGWlJXz1FF9d/05KNEYBTyNY7HW+m4JCZ8CZ8rIgdZ25jaOIAMtiOLiiva7l3bgFYopOnftSlvlndvymaLGv67uraTPRXHaT5oLCa/GkiSC1jwhWIQ2LmD5YXAoUUYpODBBjXNOE6ULkq2xO7yJdc39MeqkRcD6fwCXjWcY9GAn2BGJWO3Iss2em6ObaKMvD4QiGzK36e43zj80YTuUh5+pSn4tqheKkl73bW2Savw/7HZ8sI21CjoZYSqoKTXhxYDKz7YycwAkjcN/dai6wzTt2mbZ4plJVsaFo/b42tkYUGVnvbFGIiBHv3ALHgpyzsqkP3AiEqVvZFb2OYa/5U32e5PVszBrIML9pgWOCZyumMtqjw4FMPtf3bGcSKG54T8QR6uSuL5YVakQiVZOxBRBDv9TVGjkrfhh8U/DxVlV0HJ66ExY3VgMZDcqnOuexoun6HRr0KG7xil3YBlmJnGkyBeemeJ/CV+nBRelPYCZ/+X9C3JEIi4ACYYxOqOGwZ8JGtrDroFwdBTtI6LD6mzgQ9Dew== jule@DESKTOP-ABQ1DJO" ];
  #Services
  #zsh
    networking.networkmanager.enable = true;
  #Mullvad VPN
    services.mullvad-vpn.enable = true;
  #Flakes
  nix = {
    package = pkgs.nixVersions.stable;
    extraOptions = ''
      experimental-features = nix-command flakes
    '';
     }; 
  services.grafana = {
    enable = true;
    settings = {
     server = {
     domain = "grafana.ketamin.trade";
     http_port = 3001;
     http_addr = "::1";
      };
        "auth.anonymous" = {
        enabled = true;
        org_name = "Main Org.";
        org_role = "Viewer";
     };
  };
};
  services.prometheus = {
    scrapeConfigs = [
      {
        job_name = "nodes";
        scrape_interval = "2s";
        static_configs = [{
          targets = [ "10.10.1.25:9100" "vps.ketamin.trade:9100" "vps2.ketamin.trade:9100" "shit.ketamin.trade:9100" "localhost:9100" ];

        }];
      }
     {
        job_name = "unifi";
        scrape_interval = "2s";
        static_configs = [{
          targets = [ "localhost:9130" ];

        }];
      }
    ];
    enable = true;
    port = 1312;
    exporters = {
      node = {
        enable = true;
        enabledCollectors = [ "systemd" ];
        port = 9100;
      };
    };
  };  
  # Allow unfree packages
  nixpkgs.config.allowUnfree = true;
  #Docker
  #All my Programms :3
  environment.systemPackages = with pkgs; [
    htop
    tmux
    busybox
    prometheus
    unzip
    vim
    fastfetch
    neofetch
    zsh
    nmap
    hyfetch
    go
    lshw
    traceroute
    speedtest-cli
    rustc
    pciutils
    git
    veracrypt
    metasploit
    ecryptfs
    gnumake
    wireshark-qt
    superTuxKart
    cargo
    gcc
    cron
    vlc
    alacritty
    cmatrix
    btop
    gitlab-runner
    wget
    rclone
    restic
    gtop
    freerdp
    killall
    picocom
    dnsmasq
    spotifyd
    unifi8
    pipes
    curl
    ddclient
    docker-compose
    jellyfin
    jellyfin-web
    jellyfin-ffmpeg
    ];
    virtualisation.docker.enable = true;
    virtualisation.containerd.enable = true;
    #an openssh banner, is shown everytime you try to connect
    services.openssh.banner = "
      ***************************************************************************
                                  NOTICE TO USERS
      This is a Federal computer system and is the property of the United
      States Government. It is for authorized use only. Users (authorized or
      unauthorized) have no explicit or implicit expectation of privacy.
      Any or all uses of this system and all files on this system may be
      intercepted, monitored, recorded, copied, audited, inspected, and disclosed to
      authorized site, Department of Energy, and law enforcement personnel,
      as well as authorized officials of other agencies, both domestic and foreign.
      By using this system, the user consents to such interception, monitoring,
      recording, copying, auditing, inspection, and disclosure at the discretion of
      authorized site or Department of Energy personnel.
      Unauthorized or improper use of this system may result in administrative
      disciplinary action and civil and criminal penalties. By continuing to use
      this system you indicate your awareness of and consent to these terms and
      conditions of use. LOG OFF IMMEDIATELY if you do not agree to the conditions
      stated in this warning.
      *****************************************************************************";
# spotifyd is a service for streaming spotify to this device
services.spotifyd.enable = true;
  programs.zsh.enable = true;
    programs.zsh.ohMyZsh.enable = true;
    programs.zsh.ohMyZsh.theme = "crunch";
    programs.zsh.autosuggestions.enable = true;
    programs.zsh.shellAliases = { backup = "restic -r rclone:smb:/Buro/backup backup -p /home/marie/restic/password --verbose /home /var/lib/docker /srv";};
    programs.zsh.shellAliases = { update = "sudo nix flake update /home/marie/server";};
    programs.zsh.shellAliases = { rebuild = "sudo nixos-rebuild --flake /home/marie/server switch";};
    users.defaultUserShell = pkgs.zsh;
  #git  
    programs.git.config.user.name = "pilz0";
    programs.git.config.user.email = "marie0@riseup.net";

  environment.sessionVariables.NIXPKGS_ALLOW_UNFREE="1"; 
# Openssh
  services.openssh.enable = true;
  services.openssh.settings.PasswordAuthentication = false;
  programs.ssh.startAgent = true;
    # dyndns
nix.optimise.automatic = true;
nix.optimise.dates = [ "03:45" ];
services.tailscale.enable = true;
#systemd.services."backup" = {
  #script = ''${pkgs.restic}/bin/restic -r rclone:smb:/Buro/backup backup -p /home/marie/restic/password --verbose /home /var/lib/docker /srv
 # '';
 # serviceConfig = {
   # Type = "oneshot";
  #  User = "root";
 # };
#};
#systemd.timers."backup" = {
 # wantedBy = [ "timers.target" ];
   # timerConfig = {
   # #  OnBootSec = "10m";
   #   OnUnitActiveSec = "24h";
  #    Unit = "backup.service";
 #   };
#};
services.unifi = {
  enable = true;
  openFirewall = true;
  unifiPackage = pkgs.unifi8;
};

services.unpoller = {
  enable = true;
  influxdb.disable = true;
unifi = { 
     defaults = {
        url = "https://localhost:8443";
        user = "unpoller";
        pass = "/srv/password";
        verify_ssl = false;
    }; 
  };
};

services.tor = {
  enable = true;
  openFirewall = true;
  relay = {
    enable = true;
    role = "relay";
  };
  settings = {
    ContactInfo = "darmstadt@fridaysforfuture.de";
    Nickname = "ketamintrade";
    ORPort = 9001;
    ControlPort = 9051;
    BandWidthRate = "2 MBytes";
  };
};

services.nginx = {
    enable = true;
    recommendedGzipSettings = true;
    recommendedOptimisation = true;
    recommendedProxySettings = true;
    recommendedTlsSettings = true;
    # other Nginx options
    virtualHosts."grafana.ketamin.trade" =  {
      enableACME = true;
      forceSSL = true;
      locations."/" = {
        proxyPass = "http://localhost:3001";
        proxyWebsockets = true; # needed if you need to use WebSocket
      };
    };
    virtualHosts."caffeine.mom" =  {
      enableACME = true;
      forceSSL = true;
      locations."/" = {
        proxyPass = "http://localhost:8096";
        proxyWebsockets = true; # needed if you need to use WebSocket
      };
    };
    virtualHosts."cloud.fffda.lol" =  {
      enableACME = true;
      forceSSL = true;
      locations."/" = {
        proxyPass = "http://10.10.1.9:1100";
        proxyWebsockets = true; # needed if you need to use WebSocket
      };
    };
    virtualHosts."unifi.ketamin.trade" =  {
      enableACME = true;
      forceSSL = true;
      locations."/" = {
        proxyPass = "https://localhost:8443";
        proxyWebsockets = true; # needed if you need to use WebSocket
      };
    };
};
security.acme = {
  acceptTerms = true;
  defaults.email = "acme@ketamin.trade";
};

services.jellyfin = {
  enable = true;
  openFirewall = true;
#  dataDir = "/home/marie/jellyfin_data";
};
  # 1. enable vaapi on OS-level
  nixpkgs.config.packageOverrides = pkgs: {
    vaapiIntel = pkgs.vaapiIntel.override { enableHybridCodec = true; };
  };
  hardware.graphics = {
    enable = true;
    extraPackages = with pkgs; [
      intel-media-driver
      intel-vaapi-driver # previously vaapiIntel
      vaapiVdpau
      intel-compute-runtime # OpenCL filter support (hardware tonemapping and subtitle burn-in)
      intel-media-sdk # QSV up to 11th gen
    ];
  };

# Open ports in the firewall.
networking.firewall.allowedTCPPorts = [ 1100 11000 81 8080 443 80 22 3000 8443 1337 3001 9090 9100 1312 ];
networking.firewall.allowedUDPPorts = [ 1100 11000 81 8080 443 80 22 3000 8443 1337 3001 9090 9100 1312 ];
# Or disable the firewall altogether.
# networking.firewall.enable = false;
# NixOS Version
system.stateVersion = "23.11"; # Did you read the comment?
}
  ## github copilot wrote this
#  I hope you can help me. 
#  I’m not sure if this is the issue, but I think you need to use  users.users.marie.openssh.authorizedKeys.keys  instead of  users.users.marie.openssh.authorizedKeys . 
#  I tried it, but it didn’t work. 
#  I think the problem is that the authorizedKeys.keys is not a list of strings, but a list of objects with a key and a value. 
#  I think the problem is that the authorizedKeys.keys is not a list of strings, but a list of objects with a key and a value. 
#  That’s not correct. The  authorizedKeys.keys  attribute is a list of strings. 
#  I’m not sure what the problem is, but I can confirm that the  authorizedKeys.keys  attribute is a list of strings. 
#  I’m sorry, I was wrong.

