#! /usr/bin/env nix-shell
#! nix-shell -i bash -p acpi

# Check for the presence of a battery
if [ -d /sys/class/power_supply/BAT* ]; then
    # Infinite loop to continuously monitor BATTERY level
    while true; do
        # Capture BATTERY level (assuming BAT0 is the battery, adjust if your system is different)
        BATTERY_LEVEL=$(cat /sys/class/power_supply/BAT0/capacity)
        # Print the BATTERY level
        echo $BATTERY_LEVEL
        # Wait for a second before the next iteration
        sleep 1
    done
else
    echo "false"
    exit 0
fi

# # Infinite loop to continuously monitor BATTERY level
# while true;
# do
#     # Capture BATTERY level
#     BATTERY_LEVEL=$(acpi -b | awk '{print $4}' | sed 's/%,//')
#     # Print the BATTERY level
#     echo $BATTERY_LEVEL
#     # Wait for a second before the next iteration
#     sleep 1
# done

