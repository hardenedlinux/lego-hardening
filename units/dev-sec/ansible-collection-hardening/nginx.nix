{ ansibleCollectionHardeningSrc }:
let
  defaults = ansibleCollectionHardeningSrc.roles.nginx_hardening.defaults.main;
  argument_specs =
    ansibleCollectionHardeningSrc.roles.nginx_hardening.meta.argument_specs;
in
{
  inherit defaults argument_specs;
}
