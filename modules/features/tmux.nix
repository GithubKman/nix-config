{
  flake.nixosModules.tmux =
    { config, pkgs, ... }:
    {
      home-manager.users.${config.my.username}.programs.tmux = {
        enable = true;
        mouse = true;
        prefix = "C-Space";
        keyMode = "vi";
        historyLimit = 50000;
        baseIndex = 1;
        plugins = with pkgs.tmuxPlugins; [
          sensible
          resurrect
          continuum
          tmux-fzf
          sessionist
        ];
        extraConfig = ''
          # Additional custom settings
          set -g status-position top
          bind-key -T copy-mode-vi v send-keys -X begin-selection
          bind-key -T copy-mode-vi y send-keys -X copy-selection-and-cancel
        '';
      };
    };
}
