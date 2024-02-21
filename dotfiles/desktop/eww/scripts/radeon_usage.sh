#! /usr/bin/env nix-shell
#! nix-shell -i bash -p radeontop

# Infinite loop to continuously monitor AMD GPU usage
while true; do
    # Check if the GPU usage file exists and is readable
    if [ -r /sys/class/drm/card0/device/gpu_busy_percent ]; then
        # Capture AMD GPU usage
        GPU_USAGE=$(cat /sys/class/drm/card0/device/gpu_busy_percent)
        # Print the GPU usage
        echo $GPU_USAGE
    else
        echo "GPU usage information not available or not readable"
    fi
    # Wait for a second before the next iteration
    sleep 1
done

