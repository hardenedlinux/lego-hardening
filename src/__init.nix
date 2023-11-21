{ omnibus, inputs }:
{
  nixosProfiles = {
    apparmor = omnibus.pops.nixosProfiles.addLoadExtender {
      load = {
        src = ./apparmor;
        inputs = {
          inherit inputs;
        };
      };
    };
  };
}
