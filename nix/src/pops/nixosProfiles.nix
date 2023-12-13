{
  omnibus,
  projectDir,
  inputs,
  eachSystem,
}:
{
  apparmor = omnibus.pops.nixosProfiles.addLoadExtender {
    load = {
      src = projectDir + /units/apparmor;
      inputs = {
        inherit inputs;
      };
    };
  };
  nixos = eachSystem (
    system:
    omnibus.pops.nixosProfiles.addLoadExtender {
      load = {
        src = projectDir + /units/nixosProfiles;
        type = "nixosProfilesOmnibus";
        inputs = {
          inherit system;
          inputs = inputs // {
            inherit ((omnibus.flake.setSystem system).inputs) nixos-23_11;
          };
        };
      };
    }
  );
}
