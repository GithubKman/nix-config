{
  flake.nixosModules.ai =
    { pkgs, ... }:
    {
      environment.systemPackages = [ pkgs.ollama ];
      services.ollama = {
        enable = false;
        loadModels = [ "llama3.1:8b" ];
        package = pkgs.ollama-cuda;
      };
    };
}
