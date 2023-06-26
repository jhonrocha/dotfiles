#!/bin/sh
# The Sway configuration file in ~/.config/sway/config calls this script.
# You should see changes to the status bar after saving this script.
# If not, do "killall swaybar" and $mod+Shift+c to reload the configuration.

# The abbreviated weekday (e.g., "Sat"), followed by the ISO-formatted date
# like 2018-10-06 and the time (e.g., 14:01)
date=$(date "+%b %d, %H:%M")
us_date=$(TZ="America/Los_Angeles" date "+%H:%M")

# Returns the battery status: "Full", "Discharging", or "Charging".
# battery_status=$(cat /sys/class/power_supply/BAT0/status)

mem_used=$(free -m | awk '/Mem/ {print $3"M"}')

cpu_usage=$(top -bn1 | grep -Po "[0-9.]*(?=( id,))" | awk '{print 100 - $1"%"}')
# cpu_usage=$(mpstat | awk '$3 ~ /CPU/ { for(i=1;i<=NF;i++) { if ($i ~ /%idle/) field=i } } $3 ~ /all/ { print 100 - $field }')

cpu_temp=$(sensors | awk '/Package/ {print +$4"ºC"}')


volume=$(pactl get-sink-volume 0 left | awk -F" / " '/left/ { print $2 }')

color1="#d670d6"
color2="#3b8eea"
echo -ne "\
<span foreground='$color1'></span><span weight='bold' background='$color1' foreground='#000000'> $volume </span>\
<span foreground='$color2' background='$color1'></span><span weight='bold' background='$color2' foreground='#000000'> $mem_used </span>\
<span foreground='$color1' background='$color2'></span><span weight='bold' background='$color1' foreground='#000000'> $cpu_temp </span>\
<span foreground='$color2' background='$color1'></span><span weight='bold' background='$color2' foreground='#000000'> ﬙ $cpu_usage </span>\
<span foreground='$color1' background='$color2'></span><span weight='bold' background='$color1' foreground='#000000'> $us_date </span>\
<span foreground='$color2' background='$color1'></span><span weight='bold' background='$color2' foreground='#000000'> $date </span><span foreground='$color2'></span>"
