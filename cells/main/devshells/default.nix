{
  inputs,
  cell,
}: let
  l = nixpkgs.lib // builtins;
  inherit (inputs) nixpkgs std;
in
  l.mapAttrs (_: std.std.lib.mkShell) {
    default = {...}: {
      name = "HardenedNixOS";
      imports = [
        inputs.cells-lab.main.devshellProfiles.default
        inputs.cells-lab.main.devshellProfiles.docs
      ];
    };
  }
