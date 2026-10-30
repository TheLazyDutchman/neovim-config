{
  description = "Description for the project";

  inputs = {
    flake-parts.url = "github:hercules-ci/flake-parts";
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
    nvf = {
      url = "github:notashelf/nvf";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    nanamiiiii = {
      url = "github:Nanamiiiii/nur";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs =
    inputs@{ flake-parts, ... }:
    flake-parts.lib.mkFlake { inherit inputs; } (
      { moduleWithSystem, ... }: {
        imports = [
          ./obsidian_headless.nix
        ];
        systems = [
          "x86_64-linux"
          "aarch64-linux"
          "aarch64-darwin"
        ];
        perSystem =
          {
            config,
            self',
            inputs',
            pkgs,
            system,
            lib,
            ...
          }:
          {
            options.rust = with lib; {
              enable = mkOption {
                default = true;
                example = false;
                description = "Wether to enable The Rust programming language";
                type = types.bool;
              };

              rust-analyzer.package = mkOption {
                default = null;
                description = "Which package to use for the rust-analyzer language server\n\tIf 'null', uses the default package from 'nvf'";
                type = types.nullOr types.package;
              };
            };

            config = {
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
          };
        flake = {
          nixosModules.default = moduleWithSystem (
            { pkgs, self', ... }:
            {
              environment.systemPackages = [
                self'.packages.myNeovim
              ];
              programs.neovim.enable = true;
              programs.neovim.defaultEditor = true;
            }
          );
        };
      }
    );
}
