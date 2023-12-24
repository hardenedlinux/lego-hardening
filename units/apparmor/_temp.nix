_:
{ pkgs }:
{
  bin =
    {
      name,
      package,
      extraRules ? "",
    }:
    {
      "bin-${name}".profile = ''
        include <tunables/global>
        ${package}/bin/${name} {
          # include <abstractions/base>
          # include <abstractions/nameservice>
          # include <abstractions/ssl_certs>
          include "${pkgs.apparmorRulesFromClosure { inherit name; } package}"
          r ${package}/bin/${name},
        }
        ${extraRules}
      '';
    };
}
