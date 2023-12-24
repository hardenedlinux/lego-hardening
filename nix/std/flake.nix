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

  inputs = {
    nixpkgs.follows = "omnibusStd/nixpkgs";
    omnibusStd.url = "github:gtrunsec/omnibus/?dir=local";
    call-flake.follows = "omnibusStd/call-flake";
    std.follows = "omnibusStd/std";
  };
  outputs =
    { std, call-flake, ... }@inputs:
    std.growOn
      {
        inputs =
          inputs
          // (call-flake ../lock).inputs
          // (call-flake ../..).inputs
          // {
            lego-hardening = call-flake ../..;
            omnibus = import (call-flake ../..).inputs.omnibus;
          };
        cellsFrom = ./cells;

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
