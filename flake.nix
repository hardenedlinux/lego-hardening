{
  description = "Hardening your OS/Profile is like building with LEGO";

  inputs = {
    omnibus.url = "github:gtrunsec/omnibus";
  };

  outputs =
    {self, omnibus}@inputs:
    let
      src = import ./nix/src/__init.nix {inherit inputs omnibus;};
      inherit (omnibus.lib) mapPopsExports;
    in
    src.flakeOutputs
    // {
      inherit src;
      inherit (src) pops;
    };
}
