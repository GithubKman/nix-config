{ inputs, ... }:
{
  flake.nixosModules.stylix =
    { config, pkgs, ... }:
    {
      imports = [ inputs.stylix.nixosModules.stylix ];

      stylix = {
        enable = true;
        autoEnable = true;
        base16Scheme = "${pkgs.base16-schemes}/share/themes/tokyo-night-dark.yaml";
        polarity = "dark";
        targets.gtk.enable = true;

        fonts = {
          sizes = {
            terminal = 12;
            desktop = 10;
          };
          monospace = {
            package = pkgs.nerd-fonts.jetbrains-mono;
            name = "JetBrainsMono Nerd Font";
          };
        };
      };

      home-manager.users.${config.my.username} = {
        home.pointerCursor = {
          enable = true;
          name = "Adwaita";
          package = pkgs.adwaita-icon-theme;
          size = 24;
          gtk.enable = true;
          x11.enable = true;
        };
        stylix.targets.wayprompt.enable = false;

        gtk = {
          enable = true;
          gtk3.extraConfig.gtk-application-prefer-dark-theme = 1;
          gtk4.extraConfig.gtk-application-prefer-dark-theme = 1;
        };
      };
    };
}
