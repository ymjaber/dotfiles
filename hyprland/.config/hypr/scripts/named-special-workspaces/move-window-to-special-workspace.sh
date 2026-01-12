#!/bin/bash

# Get list of active special workspaces
active_specials=$(hyprctl workspaces -j | jq -r '.[] | select(.name | startswith("special:")) | .name' | sed 's/^special://')

# Format the list for wofi
if [ -n "$active_specials" ]; then
    # Create the list with active workspaces
    workspace_list="$active_specials"
else
    # No active special workspaces
    workspace_list=""
fi

# Get workspace name from user input using wofi, showing active workspaces
workspace_name=$(echo -e "$workspace_list" | wofi --dmenu --prompt="Move to special workspace:" --width=300 --height=300 --location=center)

# Check if user entered a name
if [ -n "$workspace_name" ]; then
    # Move current window to the special workspace with the given name
    hyprctl dispatch movetoworkspace special:$workspace_name
fi
