{
  writeShellApplication,
  bash,
  nodejs,
  unzip,
  jq,
  version,
  ...
}:
writeShellApplication {
  name = "foundryvtt-bootstrap";
  runtimeInputs = [
    bash
    unzip
    nodejs
    jq
  ];
  text = ''
    #!/bin/bash

    INSTALL_DIR="/opt/fvtt/install"
    INSTALL_CACHE="/opt/fvtt_static/FoundryVTT-${version}.zip"
    export FOUNDRY_VTT_DATA_PATH="/opt/fvtt/data" 

    # If the install directory doesn't exist:
    #   - extract Foundry from the cache
    #   - make the Config and Data directories
    #   - symlink the shared data 
    if [ ! -d $INSTALL_DIR ]; then
      unzip $INSTALL_CACHE -d $INSTALL_DIR
      mkdir -p $FOUNDRY_VTT_DATA_PATH/Config
      mkdir -p $FOUNDRY_VTT_DATA_PATH/Data
      ln -s /opt/fvtt_static/shared $FOUNDRY_VTT_DATA_PATH/Data/Shared
    fi

    CURRENT_OPTIONS=$FOUNDRY_VTT_DATA_PATH/Config/options.json
    if [ -f "$CURRENT_OPTIONS" ]; then
        # If the file exists, merge it with the new options
        ${jq}/bin/jq -s add "$CURRENT_OPTIONS" /etc/fvtt/options.json > "$CURRENT_OPTIONS".tmp
    else
        # If the file does not exist, just copy the new options as the entire file
        cp /etc/fvtt/options.json "$CURRENT_OPTIONS".tmp
    fi
    mv "$CURRENT_OPTIONS".tmp $CURRENT_OPTIONS

    # Run Foundry itself
    node $INSTALL_DIR/resources/app/main.js
  '';
}
