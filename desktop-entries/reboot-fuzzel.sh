#!/usr/bin/env bash
sh -c 'printf "Cancel\nReboot\n" | fuzzel --dmenu --prompt="Confirm Reboot? " --lines=2 | grep -qx "Reboot" && systemctl reboot'
