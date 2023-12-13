{
  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixpkgs-unstable";
    nickel.url = "github:tweag/nickel";

    ansible-collection-hardening.url = "github:dev-sec/ansible-collection-hardening";
    ansible-collection-hardening.flake = false;
  };

  outputs = _: {};
}
