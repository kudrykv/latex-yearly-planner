{
  description = "Install latex reqs";

  inputs.flake-utils.url = "github:numtide/flake-utils";

  outputs = { self, nixpkgs, flake-utils }:
    flake-utils.lib.eachDefaultSystem (system:
      let
        pkgs = nixpkgs.legacyPackages.${system};

        # Build the plannergen as a binary using fixed input versions
        # This means that the subsequent pdf generation does not need internet access
        # and is therefore a "pure" nix output
        plannergen = pkgs.buildGoModule {
          src = self;
          name = "plannergen";
          vendorSha256 = "sha256:F3cln/CPSAonLTCvjSCMHhrzEQgWIOWw0vWwb6BG+pI=";
        };

        # Go is packaged into the devShell for developing the package,
        # but is not used for the "nix build" outputs - these use the pre-built
        # binary instead
        goDeps = [
          pkgs.go
        ];

        # Dependencies for building the latex files
        texDeps = with pkgs; [
          libuuid # for the "rev" utility
          ps # Used by build.sh
          python3 # used in the build scripts
          (texlive.combine {
            inherit (texlive)
              metafont
              scheme-small
              xcolor
              pgf
              wrapfig
              makecell
              multirow
              leading
              marginnote
              adjustbox
              multido
              varwidth
              blindtext
              setspace
              ifmtarg
              extsizes
              dashrule
              ;
          })
        ];
      in
      rec
      {
        devShell = pkgs.mkShell {
          shellHook = ''
            unset GOPATH
            unset GOROOT
            unset GO_VERSION
          '';
          buildInputs = [
            pkgs.nixpkgs-fmt # utility for pretty formatting of .nix files
          ] ++ goDeps ++ texDeps;
        };

        defaultPackage = pdfs;

        pdfs = pkgs.stdenv.mkDerivation
          {
            name = "pdfs";
            # Minimal set of dependencies to build the pdfs
            # Latex, "rev" and the built plannergen binary
            buildInputs = texDeps ++ [ plannergen ];
            PLANNER_YEAR = 2024;
            src = "${self}";
            buildCommand = ''
              cp -r $src/* .
              patchShebangs .
              chmod -R 770 *
              chmod +x *.sh
              PLANNERGEN_BINARY=plannergen eval $PWD/build.sh
              mkdir $out
              cp *.pdf $out/.
            '';
          };

      }
    );
}
