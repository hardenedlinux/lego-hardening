{ lib }:
let
  inherit (lib.omnibus) mkSuites;
in
mkSuites {
  default = [
    {
      keywords = [ "sysctl" ];
      knowledges = [
        " https://madaidans-insecurities.github.io/guides/linux-hardening.html#sysctl"
      ];
      profiles = [ ];
    }
  ];

  ipv6 = [
    {
      keywords = [ "ipv6" ];
      knowledges = [ ];
      profiles = [
        {
          "net.ipv6.conf.all.use_tempaddr" = 2;
          "net.ipv6.conf.default.use_tempaddr" = 2;
        }
      ];
    }
  ];
}
