#!/bin/bash

# Script to create a new special workspace without showing existing ones
# This prevents accidental switching to existing workspaces with similar names

# Get workspace name from user input using wofi, without showing any list
workspace_name=$(echo "" | wofi --dmenu --prompt="Enter new special workspace name:" --width=300 --height=60 --location=center --lines=0)

# Check if user entered a name
if [ -n "$workspace_name" ]; then
    # Open the special workspace with the given name
    hyprctl dispatch workspace special:$workspace_name
fi
