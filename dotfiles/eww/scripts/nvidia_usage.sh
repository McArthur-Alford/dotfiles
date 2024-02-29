#! /usr/bin/env nix-shell
#! nix-shell -i bash -p cowsay

# Infinite loop to continuously monitor GPU usage
while true;
do
    # Capture GPU usage
    GPU_USAGE=$(nvidia-smi --query-gpu=utilization.gpu --format=csv,noheader,nounits)
    # Print the GPU usage
    echo $GPU_USAGE
    # Wait for a second before the next iteration
    sleep 1
done

