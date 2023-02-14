{
  description = "Multi Architecture/System C Library CI Demo";

  inputs.flake-utils.url = "github:numtide/flake-utils";

  outputs = { self, nixpkgs, flake-utils }:
    (with flake-utils.lib; eachSystem allSystems) (system:
      let pkgs = nixpkgs.legacyPackages.${system}; in
      {
        packages = rec {
          zlib = pkgs.zlib;
          default = zlib;
        };
        apps = rec {
          zlib = flake-utils.lib.mkApp {
            drv = self.packages.${system}.zlib;
          };
          default = zlib;
        };
      }
    );
}
