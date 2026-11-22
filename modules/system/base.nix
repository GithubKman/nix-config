{
  # Packages and defaults every machine should have
  flake.nixosModules.base =
    { pkgs, ... }:
    {
      nixpkgs.config.allowUnfree = true;

      environment.systemPackages = with pkgs; [
        vim
        git
        parted
        zip
        unzip
        wget
        cifs-utils
        jq
        pstree
        cachix
        curl
        ffmpeg
        wl-clipboard
        man-pages
        man-pages-posix
        gcc
      ];

      documentation.dev.enable = true;
      environment.sessionVariables.GTK_THEME = "Adwaita:dark";
    };
}
