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


volume=$(amixer get Master | awk -F"[][]" '/Left:/ { print $2 }')

echo -ne "\
<span foreground='#c678dd' weight='bold'><span background='#c678dd' foreground='#000000'> 奔 $volume </span></span>  \
<span foreground='#ff69b4' weight='bold'><span background='#ff69b4' foreground='#000000'> $mem_used </span></span>  \
<span foreground='#ff6c6b' weight='bold'><span background='#ff6c6b' foreground='#000000'> $cpu_temp </span></span>  \
<span foreground='#c678dd' weight='bold'><span background='#c678dd' foreground='#000000'> ﬙ $cpu_usage </span></span>  \
<span foreground='#f5c02c' weight='bold'><span background='#f5c02c' foreground='#000000'> $us_date </span></span>  \
<span foreground='#46d9ff' weight='bold'><span background='#46d9ff' foreground='#000000'> $date </span></span>  "
