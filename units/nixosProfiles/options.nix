{
  inputs,
  system,
  self,
}:
{
  nginx =
    (import (inputs.nixos-23_11.outPath + "/nixos/lib/eval-config.nix") {
      inherit system;
      modules = [
        {
          services.nginx = {
            enable = true;
          };
        }
      ];
    });

  nginxNixosOptionsDoc = inputs.nixos-23_11.legacyPackages.nixosOptionsDoc {
    options = self.nginx.options.services.nginx;
  };
  nginxNixosOptionsDocJson = builtins.fromJSON (
    builtins.readFile (
      self.nginxNixosOptionsDoc.optionsJSON + "/share/doc/nixos/options.json"
    )
  );
}
