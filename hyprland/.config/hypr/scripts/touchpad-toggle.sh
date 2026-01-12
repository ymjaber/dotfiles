#!/bin/bash

# State file to track touchpad status
STATE_FILE="/tmp/touchpad_state"

name='elan0683:00-04f3:320b-touchpad'
# Check if touchpad is currently disabled
if [ -f "$STATE_FILE" ] && [ "$(cat $STATE_FILE)" = "disabled" ]; then
    # Enable touchpad
    hyprctl -r -- keyword "device[$name]:enabled" true
    echo "enabled" > "$STATE_FILE"
    notify-send "Touchpad" "Enabled" -i input-touchpad -t 2000
else
    # Disable touchpad
    hyprctl -r -- keyword "device[$name]:enabled" false
    echo "disabled" > "$STATE_FILE"
    notify-send "Touchpad" "Disabled" -i input-touchpad -t 2000
fi
