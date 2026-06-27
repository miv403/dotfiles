#!/bin/bash

# ---------------- CPU TEMP ----------------
cpu_temp=$(awk '{print int($1/1000)}' /sys/class/thermal/thermal_zone*/temp 2>/dev/null | head -n1)

if [ -z "$cpu_temp" ]; then
    cpu_temp=0
fi

# ---------------- NVIDIA GPU ----------------
nvidia_temp=$(nvidia-smi --query-gpu=temperature.gpu --format=csv,noheader,nounits 2>/dev/null | head -n1)

# ---------------- AMD GPU ----------------
amd_temp=$(for hw in /sys/class/drm/card*/device/hwmon/hwmon*/temp1_input; do
    if [ -f "$hw" ]; then
        echo $(( $(cat "$hw") / 1000 ))
        exit
    fi
done)

if [ -z "$amd_temp" ]; then
    amd_temp=$(sensors 2>/dev/null | awk '/edge|junction/ {gsub(/\+|°C/, "", $2); print int($2); exit}')
fi

# ---------------- NVME TEMPS ----------------
nvme_temps=""

for dev in /dev/nvme0n1 /dev/nvme1n1; do
    if [ -b "$dev" ]; then
        temp=$(nvme smart-log "$dev" 2>/dev/null | \
            awk -F: '/temperature/ {gsub(/[^0-9]/,"",$2); print $2; exit}')

        if [ -n "$temp" ]; then
            nvme_temps="${nvme_temps}$(basename $dev): ${temp}°C\n"
        fi
    fi
done

# ---------------- FANS ----------------
cpu_fan=$(sensors 2>/dev/null | awk '/cpu_fan/ {print $2}' | head -n1)
gpu_fan=$(sensors 2>/dev/null | awk '/gpu_fan/ {print $2}' | head -n1)

# ---------------- ICON + CPU WARNING ----------------
icon=""
class="normal"

if [ "$cpu_temp" -ge 85 ]; then
    icon="󰸁"
    class="critical"
elif [ "$cpu_temp" -ge 70 ]; then
    icon=""
    class="warning"
else
    icon=""
fi

# ---------------- TEXT ----------------
text="${cpu_temp}°C ${icon}"

# ---------------- TOOLTIP ----------------
tooltip="CPU: ${cpu_temp}°C"

if [ -n "$nvidia_temp" ]; then
    tooltip="${tooltip}\nNVIDIA GPU: ${nvidia_temp}°C"
fi

if [ -n "$amd_temp" ]; then
    tooltip="${tooltip}\nAMD GPU: ${amd_temp}°C"
fi

if [ -n "$nvme_temps" ]; then
    tooltip="${tooltip}\n\nNVMe:\n${nvme_temps}"
fi

if [ -n "$cpu_fan" ] || [ -n "$gpu_fan" ]; then
    tooltip="${tooltip}\nFans:"
    [ -n "$cpu_fan" ] && tooltip="${tooltip}\ncpu_fan: ${cpu_fan}"
    [ -n "$gpu_fan" ] && tooltip="${tooltip}\ngpu_fan: ${gpu_fan}"
fi

tooltip="${tooltip}\n\nUpdated: $(date '+%H:%M:%S')"

# ---------------- OUTPUT ----------------
echo "{\"text\":\"$text\",\"tooltip\":\"$tooltip\",\"class\":\"$class\"}"