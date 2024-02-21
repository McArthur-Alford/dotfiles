#! /usr/bin/env nix-shell
#! nix-shell -i bash -p procps

# Infinite loop to continuously monitor RAM usage
while true;
do
    # Capture RAM usage
    RAM_USAGE=$(free | awk '/Mem:/ {print $3/$2 * 100}')
    # Print the RAM usage with two decimal places
    echo $RAM_USAGE | awk '{printf "%.2f\n", $1}'
    # Wait for a second before the next iteration
    sleep 1
done

