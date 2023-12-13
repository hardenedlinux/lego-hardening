{inputs, cell}:
with inputs.std.inputs.dmerge;
let
  cfg = {
    inherit (cell.pops.configs.exports.default) treefmt lefthook conform;
  };
  inherit (cell.pops.configs.exports.stdNixago) treefmt lefthook conform;
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
}
