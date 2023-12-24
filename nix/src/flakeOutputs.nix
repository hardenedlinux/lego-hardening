{ root, lib }:
let
  units = lib.omnibus.mapPopsExports root.pops;
in
{
  inherit (units) nixosProfiles;
  inherit units;
}
