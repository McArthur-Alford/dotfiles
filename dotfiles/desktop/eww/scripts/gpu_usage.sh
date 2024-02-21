#! /usr/bin/env nix-shell
#! nix-shell -i bash -p toybox

# Detect the GPU type (NVIDIA or AMD) and execute the corresponding script

# Path to the NVIDIA and AMD specific scripts
NVIDIA_SCRIPT="./scripts/nvidia_usage.sh"
RADEON_SCRIPT="./scripts/radeon_usage.sh"

# Check for loaded NVIDIA and AMD kernel modules
if lsmod | grep -iq "nvidia"; then
    echo "NVIDIA GPU detected. Executing NVIDIA usage script."
    chmod +x $NVIDIA_SCRIPT
    $NVIDIA_SCRIPT
elif lsmod | grep -iq "amdgpu"; then
    echo "AMD GPU detected. Executing Radeon usage script."
    chmod +x $RADEON_SCRIPT
    $RADEON_SCRIPT
else
    echo "No supported GPU detected. Exiting."
    exit 1
fi
