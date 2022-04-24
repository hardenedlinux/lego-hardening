{
  description = "DevSecOps Cells Development Shells";

  inputs.devshell.url = "github:numtide/devshell";
  inputs.flake-utils.url = "github:numtide/flake-utils";
  inputs.nixpkgs.follows = "cells/nixpkgs";
  inputs.latest.follows = "cells/latest";
  inputs.std.follows = "cells/std";
  inputs.cells.url = "../.";

  outputs = inputs:
    inputs.flake-utils.lib.eachSystem ["x86_64-linux" "x86_64-darwin"] (
      system: let
        inherit
          (inputs.cells.inputs.std.deSystemize system inputs)
          cells
          devshell
          ;
        inherit
          (inputs.std.deSystemize system inputs)
          std
          ;
        latest = inputs.latest.legacyPackages.${system};
        nixpkgs = inputs.nixpkgs.legacyPackages.${system}.appendOverlays [(import ./channels-latest.nix {inherit latest;})];
      in {
        devShells.default = import ./. {inherit devshell nixpkgs cells std;};
      }
    );
}
