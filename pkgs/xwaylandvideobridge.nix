{ stdenv
, fetchFromGitLab
, cmake
, pkg-config
, extra-cmake-modules
, qt5
, libsForQt5
}: stdenv.mkDerivation rec {
  pname = "xwaylandvideobridge";
  version = "unstable-2023-03-28";

  src = fetchFromGitLab {
    domain = "invent.kde.org";
    owner = "davidedmundson";
    repo = "xwaylandvideobridge";
    rev = "b876b5f3ee5cc810c99b08e8f0ebb29553e45e47";
    hash = "sha256-gfQkOIZegxdFQ9IV2Qp/lLRtfI5/g6bDD3XRBdLh4q0=";
  };

  nativeBuildInputs = [
    cmake
    extra-cmake-modules
    pkg-config
  ];

  buildInputs = [
    qt5.qtbase
    qt5.qtquickcontrols2
    qt5.qtx11extras
    libsForQt5.kdelibs4support
    (libsForQt5.kpipewire.overrideAttrs (oldAttrs: {
      version = "unstable-2023-03-28";

      src = fetchFromGitLab {
        domain = "invent.kde.org";
        owner = "plasma";
        repo = "kpipewire";
        rev = "ed99b94be40bd8c5b7b2a2f17d0622f11b2ab7fb";
        hash = "sha256-KhmhlH7gaFGrvPaB3voQ57CKutnw5DlLOz7gy/3Mzms=";
      };
    }))
  ];

  dontWrapQtApps = true;
}

# { stdenv, fetchFromGitHub, bash }:

# stdenv.mkDerivation rec {
#   name = "nixos-shell-${version}";
#   version = "b0c0d93c0db4ce5661d0f2e6cbea4d554f9c28de";

#   src = fetchFromGitHub {
#     owner = "Mic92";
#     repo = "nixos-shell";
#     rev = "${version}";
#     sha256 = "0z2mklcdrf98mm5ywvp4n3y7rdbizjz6wnqzj6c28r0cy1an5xib";
#   };

#   patches = [ ./nixos-shell.patch ];
#   buildInputs = [ bash ];
#   preConfigure = ''
#     export PREFIX=$out
#   '';
# }

