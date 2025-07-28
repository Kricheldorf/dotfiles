#!/bin/bash

case $BLOCK_BUTTON in
    1) playerctl -p spotify_player play-pause ;;  # Left click
    3) playerctl -p spotify_player next ;;        # Right click
    2) playerctl -p spotify_player previous ;;    # Middle click
esac

STATUS=$(playerctl -p spotify_player status 2>/dev/null)

if [ "$STATUS" = "Playing" ] || [ "$STATUS" = "Paused" ]; then
    ARTIST=$(playerctl -p spotify_player metadata artist 2>/dev/null)
    TITLE=$(playerctl -p spotify_player metadata title 2>/dev/null)
    
    if [ -z "$ARTIST" ]; then ARTIST="Unknown Artist"; fi
    if [ -z "$TITLE" ]; then TITLE="Unknown Title"; fi
    
    MAX_LENGTH=120
    COMBINED="$ARTIST - $TITLE"
    if [ ${#COMBINED} -gt $MAX_LENGTH ]; then
        if [ ${#ARTIST} -gt 20 ]; then
            ARTIST="${ARTIST:0:17}..."
        fi
        if [ ${#TITLE} -gt 20 ]; then
            TITLE="${TITLE:0:17}..."
        fi
        COMBINED="$ARTIST - $TITLE"
        if [ ${#COMBINED} -gt $MAX_LENGTH ]; then
            COMBINED="${COMBINED:0:$MAX_LENGTH}..."
        fi
    fi
    
    if [ "$STATUS" = "Playing" ]; then
        ICON="♪"
    else
        ICON="⏸"
        COLOR="#999900"
    fi
    
    echo "$ICON $COMBINED"
    echo "$ICON $COMBINED"
    echo "$COLOR"
else
    echo ""
    echo ""
    echo "#666666"
fi
