#!/bin/bash

bluetoothctl devices Connected | while read -r line; do
    device_mac=$(echo "$line" | awk '{print $2}')
    if [ -n "$device_mac" ]; then
        bluetoothctl disconnect "$device_mac"
    fi
done
