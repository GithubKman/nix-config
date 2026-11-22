{
  flake.nixosModules.terminal =
    { config, ... }:
    {
      home-manager.users.${config.my.username}.programs.foot = {
        enable = true;
        # `foot --server` is started from Hyprland's autostart; `footclient` connects to it
        settings.mouse.hide-when-typing = "yes";
      };
    };
}
