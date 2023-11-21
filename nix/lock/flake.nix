{
  inputs = {
    ocsf-benthos.url = "github:ocsf/ocsf-benthos";
    ocsf-benthos.flake = false;

    nickel.url = "github:tweag/nickel";
  };

  # description = "Collection of attack frameworks and resources";
  inputs = {
    attack-control-framework-mappings = {
      url = "github:center-for-threat-informed-defense/attack-control-framework-mappings";
      flake = false;
    };

    attack-flow = {
      url = "github:center-for-threat-informed-defense/attack-flow";
      flake = false;
    };
  };

  # description = "Cybersecurity Schema Framework";
  inputs = {
    ocsf.url = "github:ocsf/ocsf-schema";
    ocsf.flake = false;
  };
  outputs = _: { };
}
