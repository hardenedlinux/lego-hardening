{inputs, cell}:
with inputs.std.inputs.dmerge;
let
  cfg = {
    inherit (cell.pops.configs.exports.default) treefmt lefthook conform;
  };
  inherit (cell.pops.configs.exports.stdNixago) treefmt lefthook conform;
  inherit (inputs) nixpkgs;
in
{
  lefthook = {
    inherit (lefthook) default;
  };
  treefmt = {
    default = (treefmt.default cfg.treefmt.nickel);
  };
  conform = rec {
    default = conform.default custom;
    custom = {
      data = {
        commit.conventional.scopes = append [".*."];
      };
    };
  };

  nginx = inputs.std.lib.dev.mkNixago {
    data = {
      ansible-collection-hardening = inputs.lego-hardening.units.ansible-collection-hardening.${nixpkgs.system}.nginx.argument_specs;
      nixos = inputs.lego-hardening.units.nixosProfiles.nixos.${nixpkgs.system}.options.nginxNixosOptionsDocJson;
    };
    output = "compare/nginx.yml";
    format = "yaml";
    hook.mode = "copy";
  };
}
