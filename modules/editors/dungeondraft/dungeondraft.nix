{ pkgs, stdenv, lib, gdb, gnome }:

let
  inherit (gnome) zenity;
  name = "dungeondraft";
  version = "1.0.3.2";
  path = lib.makeBinPath [ zenity gdb ];
in
stdenv.mkDerivation rec {
  inherit name version;

  # src = ./. + "/Dungeondraft-${version}-Linux64.zip";
  src = (pkgs.fetchurl { 
    url = "https://drive.proton.me/urls/XV7K05MPX0#xfPKZDoC6SU0";
    hash = "sha256-gBN1PUJgg7ptNY2LHEylSziHQNsg0VOK9RN5yA4CCwc="; 
  });

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
    libGLU
    krb5
    zlib
    alsaLib
    libpulseaudio
    makeWrapper
    stdenv.cc.cc.lib
  ];

  unpackCmd = "unzip $curSrc -d ./dungeondraft";

  sourceRoot = "dungeondraft";

  installPhase = ''
    name=${name}

    mkdir -p $out/bin
    mkdir -p $out/share/applications

    chmod +x Dungeondraft.x86_64

    substituteInPlace ./Dungeondraft.desktop \
      --replace '/opt/Dungeondraft/Dungeondraft.x86_64' "$out/bin/$name" \
      --replace '/opt/Dungeondraft' $out \
      --replace '/opt/Dungeondraft/Dungeondraft.png' "$out/Dungeondraft.png"

    mv ./Dungeondraft.desktop $out/share/applications/
    mv ./Dungeondraft.x86_64 "$out/$name"
    mv ./Dungeondraft.pck $out/$name.pck

    makeWrapper $out/$name $out/bin/$name \
        --prefix PATH : ${path}

    mv ./* $out
  '';
}
