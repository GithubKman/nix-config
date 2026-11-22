{
  # Hyprland: the NixOS side (session, portal) plus the Lua config, managed by home-manager.
  # The hand-written Lua lives in ./config; small generated pieces (programs, variables)
  # are written from Nix so they can reference store paths.
  flake.nixosModules.hyprland =
    { config, lib, pkgs, ... }:
    let
      hyprPackage = config.programs.hyprland.package;
    in
    {
      services.displayManager.ly.enable = true;

      programs.hyprland = {
        enable = true;
        xwayland.enable = true;
      };

      systemd.user.services.xdg-desktop-portal-hyprland = {
        unitConfig = {
          Description = "Portal service (Hyprland implementation)";
          # Force it to be bound to the graphical session
          PartOf = [ "graphical-session.target" ];
          After = [ "graphical-session.target" ];
        };
        serviceConfig = {
          # If it crashes or exits, do not automatically restart it if the session is gone
          Restart = "on-failure";
          RestartSec = "1s";
        };
      };

      home-manager.users.${config.my.username} = {
        wayland.windowManager.hyprland = {
          enable = true;
          # Hyprland itself and its portal come from the NixOS module above
          package = null;
          portalPackage = null;
          configType = "lua";

          # home-manager generates hyprland.lua and `require`s every autoLoad file
          # in alphabetical order, so the numeric prefixes keep the original load order.
          extraLuaFiles = {
            "00-variables" = ''
              mainMod = "SUPER"
              noctalia_ipc = "noctalia msg "
              current_mode = "normal"
            '';
            "01-monitors" = ./config/monitors.lua;
            "02-programs" = ''
              terminal    = "${pkgs.foot}/bin/footclient"
              fileManager = "${lib.getExe pkgs.thunar}"
              menu        = "${lib.getExe pkgs.fuzzel}"
            '';
            "03-autostart" = ./config/autostart.lua;
            "04-settings" = ./config/settings.lua;
            "05-looknfeel" = ./config/looknfeel.lua;
            "06-input" = ./config/input.lua;
            "07-binds" = ./config/binds.lua;
            "08-windowrules" = ./config/windowrules.lua;

            # Helper required by binds.lua, not loaded directly
            "scripts.mute" = {
              content = ./config/scripts/mute.lua;
              autoLoad = false;
            };
          };
        };

        # Colors are set in settings.lua; stop stylix from overriding them
        stylix.targets.hyprland.enable = false;

        # Type stubs for lua-language-server when editing the config
        xdg.configFile = {
          "hypr/stubs/hl.meta.lua".source = "${hyprPackage}/share/hypr/stubs/hl.meta.lua";
          "hypr/.luarc.json".text = builtins.toJSON {
            workspace.library = [ "stubs" ];
            diagnostics.globals = [ "hl" ];
          };
        };
      };
    };
}
