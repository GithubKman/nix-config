{
  # Desktop applications and CLI tools that don't need any configuration
  flake.nixosModules.apps =
    { config, pkgs, ... }:
    {
      services.ratbagd.enable = true;

      home-manager.users.${config.my.username} = {
        home.packages = with pkgs; [
          nerd-fonts.jetbrains-mono
          _1password-cli
          _1password-gui
          audacity
          calibre
          claude-code
          chromium
          dig
          discord
          fd
          tree-sitter
          musescore
          gnumake
          gcc
          flatpak
          ffmpeg
          feh
          jellyfin-desktop
          gh
          git-filter-repo
          herdr
          libnotify
          opencode
          qbittorrent
          ripgrep
          swaybg
          thunar
          timg
          tree
          unzip
          keepassxc
          piper
          ngrok
          qalculate-qt
          vesktop
          vlc
          wiremix
          xeyes
        ];

        programs.fuzzel.enable = true;
        stylix.targets.fuzzel.enable = true;
        programs.keepassxc = {
          enable = true;
          settings = {
            FdoSecrets.Enabled = true;
          };
        };
      };
    };
}
