#!/bin/bash

output=$(ddcutil -t getvcp 10 2>/dev/null)

if [ $? -eq 0 ]; then
    trimmed=${output#* * * }
    value=${trimmed%% *}
    echo $value > /tmp/waybar_ddcutil_value
    echo {\"percentage\": $value}
else
    echo {\"percentage\": $(cat /tmp/waybar_ddcutil_value 2>/dev/null || echo 0)}
fi
