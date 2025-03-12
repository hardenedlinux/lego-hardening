{ inputs, cell }:
let
  l = nixpkgs.lib // builtins;
  inherit (inputs) nixpkgs std;
  nixos-24_05 = import inputs.omnibus.flake.inputs.nixos-24_05.outPath {
    system = nixpkgs.system;
    config.allowUnfree = true;
  };
in
l.mapAttrs (_: std.lib.dev.mkShell) {
  default =
    { ... }:
    {
      name = "LEGO Hardening";
      imports = [
        cell.pops.devshellProfiles.exports.default.nickel
      ];

      packages = [
        # nixos-24_05.vagrant
        nixpkgs.yq-go
      ];

      nixago = [
        cell.nixago.treefmt.default
        cell.nixago.lefthook.default
        cell.nixago.conform.default
        cell.nixago.nginx
      ];
    };
}
