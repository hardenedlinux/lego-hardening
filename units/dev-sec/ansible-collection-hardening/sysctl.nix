{ansibleCollectionHardeningSrc}:
let
  converge =
    (builtins.elemAt ansibleCollectionHardeningSrc.molecule.os_hardening.converge
      0
    );
in
converge.vars.sysctl_config
