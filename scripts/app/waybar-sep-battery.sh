#!/usr/bin/env bash

BAT="/sys/class/power_supply/BATT"

capacity=$(cat "$BAT/capacity")
status=$(cat "$BAT/status")

if [ "$status" = "Charging" ]; then
	class="charging"
elif [ "$capacity" -le 15 ]; then
	class="critical"
elif [ "$capacity" -le 30 ]; then
	class="warning"
else
	class="normal"
fi

printf '{"text":"","class":"%s"}\n' "$class"
