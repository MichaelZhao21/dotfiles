#!/bin/bash

# Terminate already running bar instances
killall -q polybar

# Get current monitor dpi
current_dpi=$(xrdb -query | grep Xft.dpi | awk '{print $2}')
export DPI=$current_dpi

# Wait until Polybar has been shut down
while pgrep -u $UID -x polybar >/dev/null; do sleep 1; done

# Launch Polybar, using default config location ~/.config/polybar/config.ini
# Launch it for all monitors as well!
for m in $(polybar --list-monitors | cut -d":" -f1); do
    MONITOR=$m polybar --reload --config=~/.config/polybar/config.ini main 2>&1 | tee -a /tmp/polybar.log & disown
done

echo "Polybar launched..."

