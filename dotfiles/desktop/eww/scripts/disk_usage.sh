#! /usr/bin/env nix-shell
#! nix-shell -i bash -p coreutils

# Infinite loop to continuously monitor DISK usage
while true;
do
    # Capture DISK usage of the root partition
    DISK_USAGE=$(df / | awk 'NR==2 {print $5}')
    # Print the DISK usage
    echo $DISK_USAGE | sed 's/%//'
    # Wait for a second before the next iteration
    sleep 1
done

