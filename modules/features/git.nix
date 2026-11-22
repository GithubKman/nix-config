{
  flake.nixosModules.git =
    { config, ... }:
    {
      home-manager.users.${config.my.username} = {
        programs.git = {
          enable = true;
          settings.user = {
            name = "GithubKman";
            email = "github@k-man.co";
          };
        };
        programs.gh = {
          enable = true;
          gitCredentialHelper.enable = true;
        };
      };
    };
}
