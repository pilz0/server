### Edit this configuration file to define what should be installed on
# your system.  Help is available in the configuration.nix(5) man page
# and in the NixOS manual (accessible by running ‘nixos-help’).

{ pkgs, ... }:

{
  imports = [
    # Include the results of the hardware scan.
    ./hardware-configuration.nix
    ./net.nix
    ./services.nix
    ./monitoring.nix
    ./users.nix
    ./ssh.nix
    ./nginx.nix
    ./foo.nix
    ./zsh.nix
    ./nextcloud.nix
    ./graphics.nix
    #    ./dn42.nix
    #    ./wg.nix
    #    ./birb.nix
    ./restic.nix
  ];

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
    nvidia-docker
    htop
    nvtopPackages.nvidia
    procps
    gnumake
    m4
    cudatoolkit
    linuxPackages.nvidia_x11
    libGLU
    libGL
    xorg.libXi
    xorg.libXmu
    freeglut
    xorg.libXext
    xorg.libX11
    xorg.libXv
    xorg.libXrandr
    zlib
    ncurses5
    stdenv.cc
    binutils
    curl
    ddclient
    docker-compose
    jellyfin
    jellyfin-web
    jellyfin-ffmpeg
  ];
  nix.optimise.automatic = true;
  nix.optimise.dates = [ "03:45" ];

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
