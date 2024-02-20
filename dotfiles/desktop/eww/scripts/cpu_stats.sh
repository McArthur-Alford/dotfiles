#! /usr/bin/env nix-shell
#! nix-shell -i bash -p sysstat

# Infinite loop to continuously monitor CPU usage
while true;
do
    # Capture CPU usage using mpstat, process the output to get the usage percentage
    CPU_USAGE=$(mpstat 1 1 | awk '/Average:/ {print 100 - $NF}')
    # Print the CPU usage
    echo $CPU_USAGE
    # Wait for a second before the next iteration
    sleep 1
done
