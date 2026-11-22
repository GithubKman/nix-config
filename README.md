# NixOS config (dendritic)

Every `.nix` file under `modules/` is a [flake-parts](https://flake.parts) module, loaded
automatically by [import-tree](https://github.com/vic/import-tree). Files and directories
starting with `_` are skipped (e.g. `_hardware-configuration.nix`).

```
modules/
  parts.nix                 systems for perSystem outputs
  hosts/nixos/              flake.nixosConfigurations.nixos + host-specific settings
  system/                   base OS pieces (boot, nvidia, networking, user, home-manager, stylix, ...)
  features/                 one file/dir per feature; each defines flake.nixosModules.<name>
    hyprland/               NixOS + home-manager Hyprland, Lua config in ./config
    neovim/                 kickstart.nvim config in ./config
```

A feature keeps its NixOS and home-manager settings together. Home-manager settings go
under `home-manager.users.${config.my.username}`.

Adding a feature: create `modules/features/foo.nix` defining `flake.nixosModules.foo`,
then add `foo` to the module list in `modules/hosts/nixos/default.nix`.

```
sudo nixos-rebuild switch --flake /etc/nixos#nixos
```
