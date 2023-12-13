{ root, lib }:
let
  units = lib.mapPopsExports root.pops;
in
{
  inherit (units) nixosProfiles;
  inherit units;
}
