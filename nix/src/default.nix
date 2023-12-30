{ inputs }:
let
  inherit (inputs.omnibus.inputs.flops.inputs.nixlib) lib;
  eachSystem = lib.genAttrs [
    "x86_64-linux"
    "aarch64-linux"
    "aarch64-darwin"
  ];
in
inputs.omnibus.load {
  src = ./.;
  transformer = [ inputs.omnibus.lib.haumea.removeTopDefault ];
  inputs = {
    projectDir = ../..;
    inherit eachSystem;
  };
}
