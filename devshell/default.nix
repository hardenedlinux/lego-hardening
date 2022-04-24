{
  devshell,
  nixpkgs,
  cells,
  std,
}:
devshell.legacyPackages.mkShell ({extraModulesPath, ...}: {
  name = "DevSecOps Cells";
  imports = [
    "${extraModulesPath}/git/hooks.nix"

    std.std.devshellProfiles.default

  ];
  commands = [
    {
      name = "eval-cells";
      command = "nix-eval-jobs --gc-roots-dir $(pwd)/gcroot --flake $PRJ_ROOT/#packages.${nixpkgs.system}";
      help = "eval cells jobs by nix-eval-jobs";
    }
  ];
  packages = [
    nixpkgs.treefmt
    nixpkgs.shfmt
    nixpkgs.nodePackages.prettier
    nixpkgs.nodePackages.prettier-plugin-toml
    nixpkgs.python3Packages.black
    nixpkgs.just
  ];

  git.hooks = {
    enable = true;
    pre-commit.text = builtins.readFile ./pre-commit.bash;
  };

  devshell.startup.nodejs-setuphook = nixpkgs.lib.stringsWithDeps.noDepEntry ''
    export NODE_PATH=${nixpkgs.nodePackages.prettier-plugin-toml}/lib/node_modules:$NODE_PATH
  '';
})
