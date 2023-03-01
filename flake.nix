{
  description = "Install latex reqs";

  inputs.flake-utils.url = "github:numtide/flake-utils";

  outputs = { self, nixpkgs, flake-utils }:
    flake-utils.lib.eachDefaultSystem (system:
      let
        pkgs = nixpkgs.legacyPackages.${system};
        goDeps = [
          pkgs.go
        ];
        texDeps = with pkgs; [
          (texlive.combine {
            inherit (texlive)
              metafont
              scheme-basic
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
      {
        devShell = pkgs.mkShell {
          shellHook = ''
            unset GOPATH
            unset GOROOT
            unset GO_VERSION
          '';
          buildInputs = [
            pkgs.nixpkgs-fmt
          ] ++ goDeps ++ texDeps;
        };
      }
    );
}
