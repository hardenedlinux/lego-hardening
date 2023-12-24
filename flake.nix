{
  description = "Hardening your OS/Profile is like building with LEGO";

  inputs = {
    omnibus.url = "github:gtrunsec/omnibus";
    omnibus.flake = false;
  };

  outputs =
    { self, omnibus }@inputs:
    let
      src = import ./nix/src/__init.nix {
        inputs = inputs // {
          omnibus = import inputs.omnibus;
        };
      };
    in
    src.flakeOutputs
    // {
      inherit src;
      inherit (src) pops;
    };
}
