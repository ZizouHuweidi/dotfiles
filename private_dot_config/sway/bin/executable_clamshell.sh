#!/bin/bash

# Clamshell mode script for Sway
# Disables laptop screen when lid is closed, enables when open
# Run this on sway reload to restore correct lid state

LAPTOP_OUTPUT="eDP-1"
LID_STATE_FILE="/proc/acpi/button/lid/LID0/state"

# Check if lid state file exists, try alternative paths
if [ ! -f "$LID_STATE_FILE" ]; then
    # Try alternative paths (different laptops use different paths)
    for path in /proc/acpi/button/lid/LID*/state; do
        if [ -f "$path" ]; then
            LID_STATE_FILE="$path"
            break
        fi
    done
fi

if [ -f "$LID_STATE_FILE" ]; then
    read -r LS < "$LID_STATE_FILE"
    case "$LS" in
        *open)
            swaymsg output "$LAPTOP_OUTPUT" enable
            ;;
        *closed)
            swaymsg output "$LAPTOP_OUTPUT" disable
            ;;
    esac
fi
