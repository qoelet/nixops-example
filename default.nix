{ pkgs ? import <nixpkgs> {}, compiler ? "ghc822" }:

with pkgs;

haskell.packages.${compiler}.callPackage ./nixops-example.nix { }
