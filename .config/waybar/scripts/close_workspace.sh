#!/bin/bash
workspace_id="$1"
sleep 0.1  # Give Hyprland a moment to switch

windows=$(hyprctl clients -j | jq -r ".[] | select(.workspace.id == $workspace_id) | .address")

for win in $windows; do
    hyprctl dispatch closewindow address:$win
done
