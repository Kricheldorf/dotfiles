#!/bin/bash

TIMEZONES=("America/Sao_Paulo" "CET")
CURRENT_TZ=$(timedatectl show --property=Timezone --value)

for i in "${!TIMEZONES[@]}"; do
    if [ "${TIMEZONES[$i]}" = "$CURRENT_TZ" ]; then
        NEXT_INDEX=$(( (i + 1) % ${#TIMEZONES[@]} ))
        timedatectl set-timezone "${TIMEZONES[$NEXT_INDEX]}"
        break
    fi
done

killall -SIGUSR2 waybar 
