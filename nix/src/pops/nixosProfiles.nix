{
  omnibus,
  projectDir,
  inputs,
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
}
