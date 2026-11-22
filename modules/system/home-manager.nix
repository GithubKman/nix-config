{ inputs, ... }:
{
  # Wires home-manager into NixOS. Feature modules add their user config through
  # `home-manager.users.${config.my.username}` so each feature stays in one file.
  flake.nixosModules.home-manager =
    { config, ... }:
    {
      imports = [ inputs.home-manager.nixosModules.default ];

      home-manager = {
        useGlobalPkgs = true;
        useUserPackages = true;
        extraSpecialArgs = { inherit inputs; };
        # Existing hand-written dotfiles (e.g. ~/.config/hypr/*.lua) get renamed instead of blocking activation
        backupFileExtension = "hm-bak";

        users.${config.my.username} = {
          home.stateVersion = "26.05";

          nix.gc = {
            automatic = true;
            dates = "weekly";
            options = "--delete-older-than +8";
          };
        };
      };
    };
}
