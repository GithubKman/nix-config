{
  # Neovim with the kickstart-based config from ./config.
  # Plugins are still installed at runtime by `vim.pack`, which needs to write
  # ~/.config/nvim/nvim-pack-lock.json. So instead of linking the whole directory
  # into the read-only store, only init.lua and lua/ are linked and the
  # directory itself (and the lockfile) stays writable.
  flake.nixosModules.neovim =
    { config, lib, pkgs, ... }:
    {
      home-manager.users.${config.my.username} = {
        home.sessionVariables.EDITOR = "nvim";

        programs.neovim = {
          enable = true;
          # Don't let home-manager write init.lua; ours is linked below
          sideloadInitLua = true;
          extraPackages = with pkgs; [
            # LSPs / formatters (Mason is skipped on NixOS, see init.lua)
            rust-analyzer
            clang-tools
            lua-language-server
            stylua
            # Needed by vim.pack build hooks and nvim-treesitter
            tree-sitter
            gcc
            gnumake
            ripgrep
            fd
          ];
        };

        xdg.configFile = {
          # sideloadInitLua disables this file in home-manager; we provide our own
          "nvim/init.lua" = {
            enable = lib.mkForce true;
            source = ./config/init.lua;
          };
          "nvim/.stylua.toml".source = ./config/.stylua.toml;
          "nvim/lua" = {
            source = ./config/lua;
            recursive = true;
          };
        };
      };
    };
}
