{
  # Assorted system services and daemons
  flake.nixosModules.services = {
    hardware.bluetooth.enable = true;
    services.power-profiles-daemon.enable = true;
    services.upower.enable = true;
    services.udisks2.enable = true;
    services.flatpak.enable = true;
    services.input-remapper.enable = true;
    security.polkit.enable = true;
    virtualisation.docker.enable = true;
    programs.kdeconnect.enable = true;

    environment.etc."1passworld/custom_allowed_browsers" = {
      text = ''
        zen
        firefox
        floorp
        chromium
      '';
      mode = "0755";
    };
  };
}
