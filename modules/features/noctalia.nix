{
  # Noctalia shell (bar, launcher, notifications). Started from Hyprland's autostart.
  flake.nixosModules.noctalia =
    { config, ... }:
    {
      home-manager.users.${config.my.username}.programs.noctalia = {
        enable = true;
        settings = {
          # configure options
        };
      };
    };
}
