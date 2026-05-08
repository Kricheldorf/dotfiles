#!/usr/bin/env sh
# Focus existing window by class regex, else launch command.
# Usage: focus-or-launch.sh <class-regex> <command> [args...]

set -eu

if [ $# -lt 2 ]; then
    echo "usage: $0 <class-regex> <command> [args...]" >&2
    exit 1
fi

class_re="$1"
shift

addr=$(hyprctl clients -j | jq -r --arg c "$class_re" '.[] | select(.class | test($c)) | .address' | head -1)

if [ -n "$addr" ]; then
    hyprctl dispatch focuswindow "address:$addr"
else
    setsid "$@" >/dev/null 2>&1 &
fi
