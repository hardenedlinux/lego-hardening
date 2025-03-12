{
  nixConfig = {
    extra-substituters = [
      "https://tweag-topiary.cachix.org"
      "https://tweag-nickel.cachix.org"
      "https://organist.cachix.org"
    ];
    extra-trusted-public-keys = [
      "tweag-topiary.cachix.org-1:8TKqya43LAfj4qNHnljLpuBnxAY/YwEBfzo3kzXxNY0="
      "tweag-nickel.cachix.org-1:GIthuiK4LRgnW64ALYEoioVUQBWs0jexyoYVeLDBwRA="
      "organist.cachix.org-1:GB9gOx3rbGl7YEh6DwOscD1+E/Gc5ZCnzqwObNH2Faw="
    ];
  };

  inputs = { };
  outputs =
    inputs:
    let
      inputsSource = inputs // rec {
        omnibus = import (import ../..).inputs.omnibusSrc;
        inherit (omnibus.flake.inputs) std;
      };
      inherit (inputsSource.omnibus.flake.inputs) std;
      inherit (inputsSource.omnibus) call-flake;
    in
    std.growOn
      {
        inputs =
          inputsSource
          // (call-flake ../lock).inputs
          // (call-flake ../..).inputs
          // {
            lego-hardening = call-flake ../..;
          };
        cellsFrom = ./cells;

        nixpkgsConfig = {
          allowUnfree = true;
        };

        cellBlocks = with std.blockTypes; [
          (installables "packages")

          (functions "shellsProfiles")
          (devshells "shells")

          (runnables "entrypoints")
          (runnables "scripts")
          (runnables "tasks")

          (functions "lib")

          (functions "packages")

          (functions "pops")

          (data "config")
          (files "configFiles")

          (data "jsonschemas")

          (files "schemas")

          (nixago "nixago")
        ];
      }
      {
        devShells = inputs.std.harvest inputs.self [
          "repo"
          "shells"
        ];
      };
}
