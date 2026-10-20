#!/usr/bin/env bash
sh -c 'printf "Cancel\nLogout\n" | fuzzel --dmenu --prompt="Confirm Logout? " --lines=2 | grep -qx "Logout" && niri msg action quit --skip-confirmation'

