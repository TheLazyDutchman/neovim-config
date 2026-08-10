{
  self,
  pkgs,
  inputs,
  lib,
  ...
}:
{

  flake.nixosModules.obsidian-headless = { pkgs, ... }: {
    # TODO: change this to `pkgs.obsidian-headless` when [this PR is merged](https://github.com/NixOs/nixpkgs/pull/495287)
    # environment.systemPackages = [ pkgs.obsidian-headless ];

    environment.systemPackages = [
      inputs.nanamiiiii.packages.${pkgs.stdenv.hostPlatform.system}.obsidian-headless
    ];
  };
}
