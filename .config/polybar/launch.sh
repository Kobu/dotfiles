#!/bin/bash

killall -q polybar

while pgrep -u $UID -x polybar >/dev/null; do sleep 1; done

polybar -c /home/kobu/.config/polybar/config.ini kobu &
