{ ansibleCollectionHardeningSrc }:
let
  defaults = ansibleCollectionHardeningSrc.roles.os_hardening.defaults.main;
in
defaults
