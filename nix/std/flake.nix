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
    omnibus.url = "github:gtrunsec/omnibus";
    std.follows = "omnibusStd/std";
  };
  outputs =
    { std, omnibus, ... }@inputs:
    std.growOn
      {
        inputs = inputs // ((omnibus.pops.flake.setInitInputs ../lock).inputs);
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
