{ pkgs, config, ... }:
	{
  services.jellyfin = {
    enable = true;
    openFirewall = true;
    #  dataDir = "/home/marie/jellyfin_data";
  };
  # 1. enable vaapi on OS-level
  nixpkgs.config.packageOverrides = pkgs: {
    vaapiIntel = pkgs.vaapiIntel.override { enableHybridCodec = true; };
  };
  boot.initrd.availableKernelModules = [];
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
services.xserver.enable = true;
services.xserver.videoDrivers = ["nvidia"];
hardware.nvidia = {
    modesetting.enable = true;
    powerManagement.enable = false;
    nvidiaSettings = true;
    powerManagement.finegrained = false;
    open = false;
    package = config.boot.kernelPackages.nvidiaPackages.beta;
    nvidiaPersistenced = true;
 };
  virtualisation.docker.enable = true;
  virtualisation.containerd.enable = true;
  services.tailscale.enable = true;
  programs.git.config.user.name = "pilz0";
  programs.git.config.user.email = "marie0@riseup.net";

  services.writefreely = {
    enable = true;
    admin.name = "marie";
    host = "flohannes.de";
    database = {
      type = "sqlite3";
    };
    nginx = {
      enable = true;
      forceSSL = true;
    };
    acme = {
      enable = true;
    };
  };
}
