{
  description = "Description for the project";

  inputs = {
    flake-parts.url = "github:hercules-ci/flake-parts";
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
    nvf.url = "github:notashelf/nvf"; # Neovim configuration with Nix
  };

  outputs =
    inputs@{ flake-parts, ... }:
    flake-parts.lib.mkFlake { inherit inputs; } {
      imports = [
        ./obsidian_headless.nix
      ];
      systems = [
        "x86_64-linux"
        "aarch64-linux"
        "aarch64-darwin"
        "x86_64-darwin"
      ];
      perSystem =
        {
          config,
          self',
          inputs',
          pkgs,
          system,
          ...
        }:
        {
          packages.myNeovim =
            (inputs.nvf.lib.neovimConfiguration {
              inherit pkgs;
              modules = [
                ./configuration.nix
                ./keymaps.nix
                ./obsidian.nix
              ];
            }).neovim;
          packages.default = self'.packages.myNeovim;
        };
      flake = {
        nixosModules.default =
          { moduleWithSystem, ... }:
          (
            perSystem@{ packages, ... }:
            nixos@{ ... }:
            {
              environment.systemPackages = [
                perSystem.packages.neovim
              ];
              programs.neovim.enable = true;
              programs.neovim.defaultEditor = true;
            }
          );
      };
    };
}
