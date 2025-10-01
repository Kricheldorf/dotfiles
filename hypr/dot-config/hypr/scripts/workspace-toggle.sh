#!/bin/bash

target_workspace=$1
current_workspace=$(hyprctl activeworkspace -j | jq '.id')
special=$(hyprctl monitors -j | jq -r '.[] | select(.focused == true) | .specialWorkspace.name' | sed 's/special://')

if [[ "$special" != "" ]]; then
    hyprctl dispatch togglespecialworkspace "$special"
    hyprctl dispatch workspace "$target_workspace"
    exit 0
fi

if [ "$current_workspace" = "$target_workspace" ]; then
    hyprctl dispatch workspace previous
else
    hyprctl dispatch workspace "$target_workspace"
fi

