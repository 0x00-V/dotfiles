#!/bin/bash

BATTERY=$(upower -e | grep 'BAT')
if [[ -z "$BATTERY" ]]; then
  printf '{"text": " ??", "class": "critical", "alt": "unknown"}\n'
  exit 0
fi

PERCENT=$(upower -i "$BATTERY" | awk '/percentage/ {print $2}' | tr -d '%')
STATE=$(upower -i "$BATTERY" | awk '/state/ {print $2}')

# Class for styling
if [[ $STATE == "charging" ]]; then
  CLASS="charging"
elif [[ $PERCENT -le 10 ]]; then
  CLASS="critical"
elif [[ $PERCENT -le 20 ]]; then
  CLASS="warning"
else
  CLASS="normal"
fi

# Icon set
if [[ $PERCENT -ge 90 ]]; then
  ICON=""
elif [[ $PERCENT -ge 70 ]]; then
  ICON=""
elif [[ $PERCENT -ge 50 ]]; then
  ICON=""
elif [[ $PERCENT -ge 30 ]]; then
  ICON=""
else
  ICON=""
fi

printf '{"text": "%s %s", "class": "%s", "alt": "%s"}\n' "$ICON" "$PERCENT" "$CLASS" "$STATE"
