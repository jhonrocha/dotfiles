#!/bin/bash

# Terminate already running bar instances
killall -q dunst

# Wait until the processes have been shut down
while pgrep -u $UID -x dunst >/dev/null; do sleep 1; done

# Launch dunst
dunst &
echo "Dunst launched..."
