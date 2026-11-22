{
  flake.nixosModules.user =
    { config, lib, pkgs, ... }:
    {
      # Feature modules refer to the user through this option instead of hard-coding it
      options.my.username = lib.mkOption {
        type = lib.types.str;
        default = "kman";
        description = "Primary user account; home-manager config from feature modules is applied to it.";
      };

      config.users.users.${config.my.username} = {
        isNormalUser = true;
        extraGroups = [
          "wheel"
          "docker"
        ];
        shell = pkgs.bash;
      };
    };
}
