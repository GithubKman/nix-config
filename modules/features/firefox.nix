{
  flake.nixosModules.firefox =
    { config, ... }:
    {
      home-manager.users.${config.my.username} = {
        programs.firefox = {
          enable = true;
          profiles.default = {
            id = 0;
            name = "default";
            isDefault = true;
            extensions.force = true;
            settings = { };
          };
          policies.ExtensionSettings = {
            # uBlock Origin
            "uBlock0@raymondhill.net" = {
              install_url = "https://addons.mozilla.org/firefox/downloads/latest/ublock-origin/latest.xpi";
              installation_mode = "force_installed";
            };
            # 1Password
            "{d634138d-c276-41f9-99a9-8a0e61d29b74}" = {
              install_url = "https://addons.mozilla.org/firefox/downloads/latest/1password-x-password-manager/latest.xpi";
              installation_mode = "force_installed";
            };
          };
        };

        stylix.targets.firefox = {
          profileNames = [ "default" ];
          colorTheme.enable = true;
        };
      };
    };
}
