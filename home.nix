{ config, pkgs, ... }:

{

  home.packages = with pkgs; [
    nerd-fonts.jetbrains-mono
    prismlauncher
    _1password-gui
    _1password-cli
    vesktop
    feh
    xeyes
    tree
    foot
    neovim
    thunar
    swaybg
  ];
  
  programs.fastfetch.enable = true;
  programs.fish = {
    enable = true;
    interactiveShellInit = ''
      fish_vi_key_bindings
      abbr -a nvim vim
      abbr -a gac "git add . && git commit -m"
      fastfetch
    '';
  };
  programs.starship.enable = true;

  services.dunst.enable = true;
  programs.fuzzel.enable = true;
  programs.btop = {
    enable = true;
    settings = {
      update_ms = 500;
    };
  };
  


  home.pointerCursor = {
    name = "Adwaita";
    package = pkgs.adwaita-icon-theme;
    size = 24;
    gtk.enable = true;
    x11.enable = true;
  };

  programs.git = {
    enable = true;
    settings = {
      user = {
        name = "Calum Hansen";
        email = "git@k-man.co";
      };
    };
  };
  programs.foot = {
    enable = true;
    server.enable = true;
    settings = {
      mouse = {
        hide-when-typing = "yes";
      };
    };
  };
 
  programs.firefox = {
    enable = true;
    profiles = {
      default = {
        id = 0;
        name = "default";
        isDefault = true;
        extensions.force = true;
        
        settings = {};
        };
      };
    policies = {
      ExtensionSettings = {
        # "*" is a wildcard configuration for all other extensions (optional)
        # Setting it to "blocked" ensures only explicitly allowed extensions can run
        # "*" = { installation_mode = "blocked"; }; 
  
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
  };
  stylix.targets.firefox.profileNames = [ "default" ];
  stylix.targets.firefox.colorTheme.enable = true;
  stylix.targets.fuzzel.enable = true;
  

  gtk = {
    enable = true;
    gtk3.extraConfig = {
      gtk-application-prefer-dark-theme = 1;
    };
    gtk4.extraConfig = {
      gtk-application-prefer-dark-theme = 1;
    };
  };
  

  home.stateVersion = "26.05";
}
