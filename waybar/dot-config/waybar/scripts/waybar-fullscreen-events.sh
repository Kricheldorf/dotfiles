#!/bin/bash

# Restore default SIGPIPE so an orphaned instance (left over after a waybar
# restart) dies cleanly instead of spamming "write error: Broken pipe".
trap - PIPE

# Shows fullscreen state of the *focused* window.
# Hyprland reports `fullscreen`/`fullscreenClient` as ints (0 = none,
# 1 = maximize, 2 = fullscreen), so test against 0, not `true`.
check_fullscreen() {
    win=$(hyprctl activewindow -j 2>/dev/null)
    internal=$(echo "$win" | jq -r '.fullscreen // 0' 2>/dev/null)
    [ -z "$internal" ] && internal=0

    if [ "$internal" != "0" ]; then
        echo '{"text": "󰊓 ", "class": "fullscreen", "tooltip": "Window fullscreen (maximize)"}'
    else
        echo '{"text": "", "class": "no-fullscreen", "tooltip": "No fullscreen"}'
    fi || exit 0
}

check_fullscreen

nc -U "$XDG_RUNTIME_DIR/hypr/$HYPRLAND_INSTANCE_SIGNATURE/.socket2.sock" </dev/null | while read -r event; do
    case "$event" in
        "fullscreen"*|"activewindow"*|"workspace"*|"openwindow"*|"closewindow"*)
            check_fullscreen
            ;;
    esac
done
