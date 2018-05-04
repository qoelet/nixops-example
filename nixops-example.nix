{ mkDerivation, stdenv, base, hpack, http-types, wai, warp }:

mkDerivation rec {
  pname = "nixops-example";
  version = "1.0.0";
  src = ./.;
  buildTools = [ hpack ];
  preConfigure = "hpack .";

  isLibrary = false;
  isExecutable = true;
  executableHaskellDepends = [
    base http-types wai warp
  ];
  homepage = "https://github.com/qoelet/nixops-example";
  license = stdenv.lib.licenses.bsd3;
}
