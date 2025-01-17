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

        defaultPackage = packages.pdf-next;

        packages =
          let
            # Next year, as a string
            next-year = builtins.readFile (
              pkgs.stdenv.mkDerivation {
                name = "current-year";
                buildInputs = [ pkgs.coreutils ];
                buildCommand = ''
                  date -d "+1 year" +%Y > $out
                '';
              });

            # List of years to always build
            build-years = [
              "2025"
              "2026"
              "2027"
              "2028"
              "2029"
              "2030"
            ];

            # Function that, given a year, builds a pdf for it
            make-PDF = year: pkgs.stdenv.mkDerivation
              {
                name = "pdfs";
                # Minimal set of dependencies to build the pdfs:
                # Latex and the built plannergen binary
                buildInputs = texDeps ++ [ plannergen ];
                src = "${self}";
                buildCommand = ''
                  cp -r $src/* .
                  patchShebangs .
                  chmod -R 770 *
                  chmod +x *.sh
                  PLANNERGEN_BINARY=plannergen eval $PWD/build.sh ${year}
                  mkdir $out
                  cp *.pdf $out/.
                '';
              };

            list-of-pdfs = map (y: { name = "pdf-${y}"; value = make-PDF y; }) build-years;
          in
          builtins.listToAttrs list-of-pdfs
          // {
            # Append next year's pdf which is the default output
            pdf-next = make-PDF next-year;

            # Also output all pdfs in the same derivation for the GitHub action
            pdf-all = pkgs.stdenv.mkDerivation {
              name = "all-pdfs";
              buildCommand = ''
                mkdir $out
                cp -r ${builtins.concatStringsSep " " (map (x: "${x.value}/*" ) list-of-pdfs)} $out/.
              '';
            };
          };
      }
    );
}
