#!/bin/bash

# Get the current workspace ID (excluding special workspaces)
current_workspace=$(hyprctl activeworkspace -j | jq '.id')

# Check if we're already in a special workspace
if hyprctl activeworkspace -j | grep -q "special:"; then
    # We're in a special workspace, notify user
    notify-send "Cannot move window" "You are already in a special workspace"
else
    # We're in a normal workspace, move window to special workspace
    hyprctl dispatch movetoworkspace "special:special-$current_workspace"
fi
