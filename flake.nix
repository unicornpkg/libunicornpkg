# SPDX-FileCopyrightText: 2024 awesome-computercraft contributors
#
# SPDX-License-Identifier: MIT

{
  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixpkgs-unstable";
    systems.url = "github:nix-systems/default";
  };

  outputs = { self, nixpkgs, systems, ... } @ inputs:
    let
      forEachSystem = nixpkgs.lib.genAttrs (import systems);
    in
    {
      devShells = forEachSystem
        (system:
          let
            pkgs = nixpkgs.legacyPackages.${system};
          in
          {
            default = pkgs.mkShellNoCC {
              packages = with pkgs; [
                just
                craftos-pc
                selene
              ];
            };
            lint = pkgs.mkShellNoCC {
              packages = with pkgs; [
                just
                python3Packages.tappy
                selene
              ];
            };
          });
    };
}