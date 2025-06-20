#!/usr/bin/env bash
# vim:sw=4:ts=4:expandtab

# Taken from: https://github.com/Airblader/dotfiles-manjaro/blob/master/scripts/fullscreen_wrap.sh
# Known from this comment: https://www.reddit.com/r/i3wm/comments/4ngs25/comment/d43rb0l/

# +++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
# + Usage: fullscreen_wrap.sh <command>
# +
# +   This script checks whether the focused window is currently in fullscreen
# +   mode. If so, it disables the fullscreen for it, runs the passed command
# +   and enables fullscreen for the window again once the command exits.
# +
# +   If the focused window is currently not in fullscreen mode, it will
# +   simply run the command and exit.
# +
# +   Usage on i3 config: bindsym ... exec --no-startup-id /path/to/fullscreen_wrap_changed.sh i3-msg focus left
# +++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++

COMMAND="$@"
FOCUSED=$(xprop -root _NET_ACTIVE_WINDOW | awk -F' ' '{print $NF}')

if xprop -id ${FOCUSED} _NET_WM_STATE | grep -q _NET_WM_STATE_FULLSCREEN; then
    i3-msg "[id=${FOCUSED}] fullscreen disable"
    ${COMMAND}
    i3-msg "[id=${FOCUSED}] fullscreen enable"
else
    ${COMMAND}
fi
