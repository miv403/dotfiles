#!/usr/bin/env bash

source ~/.bashrc

( setsid -w waybar ) >/run/user/1000/waybar.log 2>&1 || notify-send "waybar stopped $(date)"

# i=0;
# while (( i++ < 5 ));
# do
#     setsid -w waybar >/run/user/1000/waybar-$i.log 2>&1;
#     notify-send "Waybar Process Interrupted $i" "Restarting bar in 2 seconds...";
#     sleep 2;
# done
