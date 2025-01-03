{
  stdenv,
  lib,
  fetchurl,
  glib,
  dbus_libs,
  dpkg,
  autoPatchelfHook,
  writeShellScript,
  curl,
  jq,
  makeWrapper,
  fontconfig,
  libusb,
  freetype,
  zlib,
  libGL,
  xorg,
  libxcb,
  common-updater-scripts,
}:

stdenv.mkDerivation rec {
  pname = "xp_pen_driver";
  version = "3.2.0.210804-1";

  src = fetchurl {
    url = "https://github.com/peterwilli/XP-Pen-Pentablet-Driver-for-Nixos/releases/download/3.2.0.210804-1/XP-PEN-pentablet-3.2.0.210804-1.x86_64.deb";
    sha256 = "01zhaxar009jck3fi6ms79f4z0wd630xzplhyviilvcaghxh4vl0";
  };

  nativeBuildInputs = [
    dpkg
    libxcb
    zlib
    libGL
    libusb
    dbus_libs
    fontconfig
    glib
    freetype
    makeWrapper
    xorg.libSM
    xorg.libXext
    xorg.libXtst
    xorg.libX11
    xorg.libXrender
    autoPatchelfHook
  ];

  dontUnpack = true;

  installPhase = ''
    runHook preInstall

    dpkg-deb -x $src $out
    chmod 755 "$out"

    chmod a+x $out/usr/lib/pentablet/pentablet.sh
    runHook postInstall
    mkdir -p $out/bin
    makeWrapper $out/usr/lib/pentablet/pentablet.sh $out/bin/pentablet
  '';

  meta = with lib; {
    description = "Blackfire Profiler agent and client";
    homepage = "https://blackfire.io/";
    license = licenses.unfree;
    maintainers = with maintainers; [ jtojnar ];
    platforms = [ "x86_64-linux" ];
  };
}
