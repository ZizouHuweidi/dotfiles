#!/bin/bash
 
entries="Active Screen Output Area Window"
 
selected=$(printf '%s\n' $entries | rofi -dmenu | awk '{print tolower($1)}')
 
case $selected in
  active)
    ~/.config/sway/bin/grimshot --notify save active;;
  screen)
    ~/.config/sway/bin/grimshot --notify save screen;;
  output)
    ~/.config/sway/bin/grimshot --notify save output;;
  area)
    ~/.config/sway/bin/grimshot --notify save area;;
  window)
    ~/.config/sway/bin/grimshot --notify save window;;
esac
