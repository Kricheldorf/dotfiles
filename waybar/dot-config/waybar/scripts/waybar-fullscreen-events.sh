#!/bin/bash

check_fullscreen() {
    current_workspace=$(hyprctl activeworkspace -j | jq -r '.id')
    fullscreen_count=$(hyprctl clients -j | jq "[.[] | select(.workspace.id == $current_workspace and .fullscreen == true)] | length")
    
    if [ "$fullscreen_count" -gt 0 ]; then
        echo '{"text": "⛶", "class": "fullscreen", "tooltip": "Window in fullscreen"}'
    else
        echo '{"text": "", "class": "no-fullscreen", "tooltip": "No fullscreen windows"}'
    fi
}

check_fullscreen

socat -u UNIX-CONNECT:$XDG_RUNTIME_DIR/hypr/$HYPRLAND_INSTANCE_SIGNATURE/.socket2.sock - | while read -r event; do
    case "$event" in
        "fullscreen"*|"workspace"*|"openwindow"*|"closewindow"*)
            check_fullscreen
            ;;
    esac
done
