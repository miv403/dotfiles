#!/usr/bin/env bash
i=0;
while (( i++ < 5 ));
do
    setsid -w waybar >/run/user/1000/waybar-$i.log 2>&1;
    notify-send "Waybar Process Interrupted $i" "Restarting bar in 2 seconds...";
    sleep 2;
done
