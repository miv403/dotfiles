#!/usr/bin/env bash
wl-mirror $(niri msg --json focused-output | jq -r .name)

