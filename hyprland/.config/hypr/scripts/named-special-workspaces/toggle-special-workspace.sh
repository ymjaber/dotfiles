#!/bin/bash

# Get the current workspace
current_workspace=$(hyprctl activewindow -j | jq -r '.workspace.name')

# Check if we're on a special workspace
if [[ $current_workspace == special:* ]]; then
    # Extract the special workspace name
    special_name=${current_workspace#special:}

    # Hide the special workspace - this will return to the previous regular workspace
    hyprctl dispatch togglespecialworkspace "$special_name"
else
    # If not on a special workspace, do nothing or notify user
    notify-send -t 2000 "Not on a special workspace" "Currently on workspace: $current_workspace"
fi
