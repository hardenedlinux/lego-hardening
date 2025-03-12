{
  description = "Hardening your OS/Profile is like building with LEGO";

  inputs = {
    omnibusSrc.url = "github:tao3k/omnibus";
    omnibusSrc.flake = false;
  };

  outputs =
    inputs:
    let
      src = import ./nix/src {
        inputs = inputs // {
          omnibus = import inputs.omnibusSrc;
        };
      };
    in
    src.flakeOutputs
    // {
      inherit src;
      inherit (src) pops;
    };
}
