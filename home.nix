{ config, pkgs, ... }:

{

  home.packages = with pkgs; [
    nerd-fonts.jetbrains-mono
  ];
  

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
      main = {
        term = "xterm-256color";
        font = "JetBrainsMono Nerd Font:size=12";
        dpi-aware = "yes";
      };
    

      mouse = {
        hide-when-typing = "yes";
      };
    };
  };
  
    

  home.stateVersion = "25.11";
}
