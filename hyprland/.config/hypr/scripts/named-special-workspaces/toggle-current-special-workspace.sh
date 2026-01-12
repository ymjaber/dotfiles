#!/bin/bash

# Get the current workspace ID (excluding special workspaces)
current_workspace=$(hyprctl activeworkspace -j | jq '.id')

# Check if we're already in a special workspace
if hyprctl activeworkspace -j | grep -q "special:"; then
    # We're in a special workspace, toggle back to normal
    hyprctl dispatch togglespecialworkspace "special-$current_workspace"
else
    # We're in a normal workspace, toggle to special workspace
    hyprctl dispatch togglespecialworkspace "special-$current_workspace"
fi
