#!/bin/bash

current=$(hyprctl activewindow -j | jq -r '.address')

hyprctl dispatch cyclenext

sleep 0.05

new_active=$(hyprctl activewindow -j | jq -r '.address')

layout=$(hyprctl activeworkspace -j | jq -r '.lastwindowtitle' 2>/dev/null)

master_info=$(hyprctl layouts -j | jq -r '.[] | select(.name == "master")')

windows=$(hyprctl clients -j | jq -r --arg ws "$(hyprctl activeworkspace -j | jq -r '.id')" '[.[] | select(.workspace.id == ($ws | tonumber))]')
master_addr=$(echo "$windows" | jq -r '.[0].address')

if [ "$new_active" != "$master_addr" ]; then
    hyprctl dispatch layoutmsg swapwithmaster master
fi
