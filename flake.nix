{
  inputs = {
    std.url = "github:divnix/std";
    data-merge.url = "github:divnix/data-merge";
    yants.url = "github:divnix/yants";

    nixpkgs.url = "github:NixOS/nixpkgs/nixpkgs-unstable";
    latest.url = "github:NixOS/nixpkgs/master";
  };

  outputs = {std, ...} @ inputs:
    std.grow {
      inherit inputs;
      cellsFrom = ./cells;
      systems = ["x86_64-linux" "x86_64-darwin"];
      organelles = [
        (std.runnables "entrypoints")

        (std.functions "library")

        (std.functions "configFiles")

        (std.functions "apparmor")
      ];
    };
}
