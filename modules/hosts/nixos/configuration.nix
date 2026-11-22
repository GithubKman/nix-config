{
  # Things that are specific to this machine rather than a reusable feature
  flake.nixosModules.nixosHost = {
    imports = [ ./_hardware-configuration.nix ];

    networking.hostName = "nixos";
    time.timeZone = "America/Denver";

    swapDevices = [
      {
        device = "/swap/swapfile";
        size = 32 * 1024;
      }
    ];
    zramSwap = {
      enable = true;
      priority = 100;
      algorithm = "zstd";
      memoryPercent = 75;
    };

    nix.settings = {
      max-jobs = 15;
      cores = 15;
    };

    # This value does NOT affect the Nixpkgs version your packages and OS are pulled from.
    # Do NOT change this value unless you have read `man configuration.nix`.
    system.stateVersion = "25.11";
  };
}
