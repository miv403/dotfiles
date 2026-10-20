#!/usr/bin/env bash
sh -c 'printf "Cancel\nPower Off\n" | fuzzel --dmenu --prompt="Confirm Power Off? " --lines=2 | grep -qx "Power Off" && systemctl poweroff'
