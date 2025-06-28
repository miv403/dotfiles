#!/usr/bin/bash

# screenshot script using imagemagick import
# 2025-06-28
# miv403@duck.com

date=$(date "+%Y-%m-%dT%H%M%S")

exec import -window root "/home/mivlab/Pictures/Screenshots/screenshot-$date.png"
