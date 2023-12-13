{
  eachSystem,
  omnibus,
  super,
  projectDir,
}:
let
  omnibusLib = eachSystem (
    system:
    omnibus.pops.self.addLoadExtender {
      load.inputs = {
        inputs = {
          nixpkgs = super.subflake.inputs.nixpkgs.legacyPackages.${system};
        };
      };
    }
  );
in
eachSystem (
  system:
  let
    ansibleCollectionHardeningSrc =
      (omnibusLib.${system}.exports.default.pops.allData.addLoadExtender {
        load = {
          src = super.subflake.inputs.ansible-collection-hardening;
        };
      }).exports.default;
  in
  omnibusLib.${system}.exports.default.pops.allData.addLoadExtender {
    load = {
      src = projectDir + "/units/dev-sec/ansible-collection-hardening";
      inputs = {
        inherit ansibleCollectionHardeningSrc;
      };
    };
  }
)
