{
  flake.nixosModules.nvidia = {
    hardware.graphics.enable = true;
    hardware.graphics.enable32Bit = true;
    services.xserver.videoDrivers = [ "nvidia" ];
    hardware.nvidia = {
      open = true;
      modesetting.enable = true;
      powerManagement.enable = true;
    };
    nixpkgs.config.cudaSupport = true;
    hardware.nvidia-container-toolkit.enable = true;
  };
}
