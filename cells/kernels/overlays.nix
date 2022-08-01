{
  inputs,
  cell,
}: {
  patchedKernel = {
    kernel,
    lib,
    ...
  }:
    kernel.override {
      kernelPatches = lib.lists.unique [
        {
          name = "example-config";
          patch = null;
          extraConfig = ''
          '';
        }
      ];
    };
}
