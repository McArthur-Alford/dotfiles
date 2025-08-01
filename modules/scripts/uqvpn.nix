{ pkgs }:
pkgs.writeScriptBin "uqvpn" ''
  #!${pkgs.bash}/bin/bash

  COOKIE=
  eval `openconnect vpn.uq.edu.au --protocol=anyconnect --useragent=AnyConnect --authenticate "$@"`
  if [ -z "$COOKIE" ]; then
    exit 1
  fi

  sudo openconnect --servercert "$FINGERPRINT" "$CONNECT_URL" --cookie-on-stdin ''\${RESOLVE:+--resolve "$RESOLVE"} <<< "$COOKIE"
''
