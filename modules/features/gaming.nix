{
  flake.nixosModules.gaming =
    { config, pkgs, ... }:
    {
      programs.steam.enable = true;

      home-manager.users.${config.my.username}.home.packages = [
        (pkgs.prismlauncher.override {
          additionalLibs = [ pkgs.glfw3-minecraft ];
        })
      ];
    };
}
