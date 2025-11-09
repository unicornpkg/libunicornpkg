# SPDX-FileCopyrightText: 2024 awesome-computercraft contributors
#
# SPDX-License-Identifier: MIT

{
  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixpkgs-unstable";
    systems.url = "github:nix-systems/default";
  };

  outputs =
    {
      self,
      nixpkgs,
      systems,
      ...
    }@inputs:
    let
      forEachSystem = nixpkgs.lib.genAttrs (import systems);
    in
    {
      devShells = forEachSystem (
        system:
        let
          pkgs = nixpkgs.legacyPackages.${system};
          sphinx-lua-ls =
            with pkgs;
            python3Packages.buildPythonPackage rec {
              pname = "sphinx-lua-ls";
              version = "3.2.0";
              pyproject = true;

              prePatch = ''
                substituteInPlace pyproject.toml --replace 'license = "MIT"' ""
              '';

              nativeBuildInputs = with python3Packages; [
                setuptools
                build
                setuptools_scm
              ];

              buildInputs = [
                python3Packages.sphinx
                python3Packages.requests
                python3Packages.pygithub
              ];

              src = fetchFromGitHub {
                owner = "taminomara";
                repo = "sphinx-lua-ls";
                tag = "v${version}";
                hash = "sha256-FdzPDhQZYUh304e/x4pa8Q8Qj1KOBtklAkr/XeTIQII=";
              };

              meta = {
                license = lib.licenses.mit;
              };
            };
        in
        {
          default = pkgs.mkShellNoCC {
            packages = with pkgs; [
              just
              craftos-pc
              python3Packages.tappy
              selene
              shellcheck
              python3Packages.uv
              lua-language-server # needed for docs
              nodejs_24
              # formatters
              treefmt
              stylua
              taplo
              nixfmt
              prettier
              shfmt
              ruff
            ];
          };
        }
      );
    };
}
