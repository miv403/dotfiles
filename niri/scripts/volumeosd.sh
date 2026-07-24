#!/usr/bin/env bash

step=0.05

case "$1" in
    up)
        wpctl set-mute @DEFAULT_SINK@ 0
        wpctl set-volume @DEFAULT_SINK@ "${step}+"
        ;;
    down)
        wpctl set-mute @DEFAULT_SINK@ 0
        wpctl set-volume @DEFAULT_SINK@ "${step}-"
        ;;
    mute)
        wpctl set-mute @DEFAULT_SINK@ toggle 
        ;;
esac

# Get volume and status and send to mako
volume=$(wpctl get-volume @DEFAULT_SINK@)
vol_value=$(echo "$volume" | awk '{print $2 * 100}')
vol_status=$(echo "$volume" | cut -d" " -f3)

if [ "$vol_status" = "[MUTED]" ]; then
    # Correct hint key for Mako to overwrite the existing popup
    notify-send -a "muted" -h string:x-canonical-private-synchronous:volume -h int:value:"$vol_value" "Muted           [$vol_value]"
    exit 0
fi

# Correct hint key for Mako to overwrite the existing popup
notify-send -a "volume" -h string:x-canonical-private-synchronous:volume -h int:value:"$vol_value" "Volume          [$vol_value]"
