{ pkgs ? import <nixpkgs> {} }:
let
  texlive = pkgs.texlive.combine {
    inherit (pkgs.texlive)
      scheme-full
      latexmk
      ;
  };
in
pkgs.mkShell {
  buildInputs = with pkgs; [ ];
  packages = [
    texlive
  ];
}