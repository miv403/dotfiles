#!/usr/bin/env bash

step=5

case "$1" in
    up)
        brightnessctl set ${step}%+
        ;;
    down)
        brightnessctl set ${step}%-
        ;;
esac

# Extract current percentage value cleanly
bright_value=$(brightnessctl -m | cut -d, -f4 | tr -d '%')

# Send to Mako using the same synchronous engine
notify-send -a "brightness" -h string:x-canonical-private-synchronous:brightness -h int:value:"$bright_value" "Brightness"
