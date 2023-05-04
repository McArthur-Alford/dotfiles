{ pkgs, stdenv }:

let
  name = "dungeondraft";
  version = "1.1.0.1";

in
stdenv.mkDerivation rec {
  inherit name version;

  src = ./. + "/Dungeondraft-${version}-Linux64.zip";

  nativeBuildInputs = with pkgs; [
    autoPatchelfHook
    unzip
  ];

  buildInputs = with pkgs; [
    xorg.libX11
    xorg.libXcursor
    xorg.libXinerama
    xorg.libXrandr
    xorg.libXi
    xorg.libXrender
    alsaLib
    libpulseaudio
    libglvnd
    libGL
  ];

  unpackCmd = "unzip $curSrc -d ./dungeondraft";

  sourceRoot = "dungeondraft";

  installPhase = ''
    mkdir -p $out/bin
    mkdir -p $out/share/applications

    chmod +x Dungeondraft.x86_64

    mv ./Dungeondraft.desktop $out/share/applications/
    mv ./Dungeondraft.x86_64 $out/bin/dungeondraft
    mv ./Dungeondraft.pck $out/bin/dungeondraft.pck

    substituteInPlace $out/share/applications/Dungeondraft.desktop \
      --replace '/opt/Dungeondraft/Dungeondraft.x86_64' "$out/bin/dungeondraft" \
      --replace '/opt/Dungeondraft' $out \
      --replace '/opt/Dungeondraft/Dungeondraft.png' "$out/dungeondraft.png"
  '';
}
