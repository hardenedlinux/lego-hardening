{
  description = "HardenedNixOS";

  inputs = {
    omnibus.url = "github:gtrunsec/omnibus";
  };

  outputs =
    { self, omnibus }@inputs:
    let
      src = import ./src/__init.nix {inherit inputs omnibus;};
      inherit (omnibus.lib) mapPopsExports;
    in
    mapPopsExports src // { pops = src; };
}
