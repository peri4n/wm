{ mkDerivation, base, containers, hpack, lib, X11, xmonad
, xmonad-contrib, xmonad-spotify
}:
mkDerivation {
  pname = "wm";
  version = "0.1.0.7";
  src = ./.;
  isLibrary = true;
  isExecutable = true;
  libraryHaskellDepends = [
    base containers X11 xmonad xmonad-contrib xmonad-spotify
  ];
  libraryToolDepends = [ hpack ];
  executableHaskellDepends = [
    base containers X11 xmonad xmonad-contrib xmonad-spotify
  ];
  testHaskellDepends = [
    base containers X11 xmonad xmonad-contrib xmonad-spotify
  ];
  prePatch = "hpack";
  homepage = "https://github.com/peri4n/wm#readme";
  license = lib.licenses.bsd3;
}
