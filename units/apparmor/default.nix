{
  lib,
  super,
  pkgs,
}:
let
  temp = super.temp { inherit pkgs; };
  binary_example = temp.bin {
    name = "binary_example";
    package = pkgs.binary_example;
    extraRules = "";
  };
in
{
  security.apparmor = {
    enable = lib.mkDefault true;
    # policies = { inherit binary_example; };
  };
}
