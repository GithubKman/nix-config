{
  # fish (launched from bash), starship, direnv, fzf and friends
  flake.nixosModules.shell =
    { config, pkgs, ... }:
    {
      programs.fish.enable = true;
      programs.bash = {
        enable = true;
        interactiveShellInit = ''
          # "check if parent process is not fish" && "make nested shells work properly"
          if grep -qv fish /proc/$PPID/comm && [[ $SHLVL == [12] ]]; then
              # set $SHELL for better integration with programs like nix shell, tmux, etc.
              SHELL=${pkgs.fish}/bin/fish exec fish
          fi
        '';
      };
      environment.shells = with pkgs; [
        bash
        fish
      ];
      programs.direnv.enable = true;

      home-manager.users.${config.my.username} = {
        home.sessionVariables.SHELL = "${pkgs.fish}/bin/fish";

        programs.bash.enable = true;
        programs.fish = {
          enable = true;
          interactiveShellInit = ''
            fish_vi_key_bindings
            abbr -a vim nvim
            abbr -a gac "git add . && git commit -m"
            function fish_greeting
              if test $(string split -f1 " " $(stty size)) -gt 26 && test $(string split -f2 " " $(stty size)) -gt 124
                fastfetch
              end
            end
            direnv hook fish | source
          '';
        };
        programs.starship = {
          enable = true;
          settings.shlvl.disabled = false;
        };
        programs.fzf = {
          enable = true;
          enableBashIntegration = true;
          enableFishIntegration = true;
        };
        programs.fastfetch.enable = true;
        programs.btop = {
          enable = true;
          settings.update_ms = 500;
        };
      };
    };
}
