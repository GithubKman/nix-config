{ self, inputs, ... }:
{
  # NOTE: 'nixos' is the hostname, so `nixos-rebuild switch --flake /etc/nixos` picks it up
  flake.nixosConfigurations.nixos = inputs.nixpkgs.lib.nixosSystem {
    specialArgs = { inherit inputs; };
    modules = with self.nixosModules; [
      nixosHost

      # system
      base
      nix-settings
      boot
      nvidia
      networking
      audio
      services
      user
      home-manager
      stylix

      # features
      shell
      tmux
      git
      terminal
      hyprland
      noctalia
      neovim
      firefox
      zen-browser
      apps
      gaming
      ai
    ];
  };
}
