{
  flake.nixosModules.networking = {
    networking.networkmanager.enable = true;
    services.tailscale.enable = true;
    services.openssh.enable = true;

    networking.firewall = {
      enable = false;
      allowedTCPPorts = [ 53 ];
      allowedUDPPorts = [
        69
        53
      ];
    };

    # Secrets live in /etc/nixos/openvpn (root-only, not tracked by git)
    services.openvpn.servers = {
      protonVPN = {
        config = ''
          config /etc/nixos/openvpn/protonVPN.conf
          auth-user-pass /etc/nixos/openvpn/pass.txt
        '';
        autoStart = false;
      };
      firewallaVPN = {
        config = "config /etc/nixos/openvpn/K-man-Firewalla.ovpn";
        autoStart = false;
      };
    };
  };
}
