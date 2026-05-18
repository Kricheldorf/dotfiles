#!/bin/sh

current_layout=$(hyprctl getoption general:layout | grep 'str:' | awk '{print $2}')

if [ "$current_layout" = "master" ]; then
    hyprctl keyword general:layout scrolling
    sleep 0.3
    hyprctl dispatch layoutmsg "fit visible"
    notify-send "Hyprland" "Layout switched to: Scrolling" -t 2000
else
    hyprctl keyword general:layout master
    notify-send "Hyprland" "Layout switched to: Master" -t 2000
fi
