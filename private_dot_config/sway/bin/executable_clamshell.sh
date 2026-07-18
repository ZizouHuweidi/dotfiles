#!/usr/bin/env bash

set -u

LAPTOP_OUTPUT="${LAPTOP_OUTPUT:-eDP-1}"
ACTION="${1:-sync}"

command -v jq >/dev/null 2>&1 || {
  logger -t sway-clamshell "jq is required"
  exit 1
}

read_lid_state() {
  local state_file

  for state_file in /proc/acpi/button/lid/LID*/state; do
    [[ -r "$state_file" ]] || continue

    if grep -qi 'closed' "$state_file"; then
      printf '%s\n' closed
    else
      printf '%s\n' open
    fi

    return 0
  done

  return 1
}

case "$ACTION" in
closed | close | on)
  STATE=closed
  ;;
open | off)
  STATE=open
  ;;
sync)
  STATE="$(read_lid_state)" || exit 0
  ;;
*)
  logger -t sway-clamshell "Unknown action: $ACTION"
  exit 2
  ;;
esac

get_outputs() {
  swaymsg -t get_outputs -r 2>/dev/null
}

OUTPUTS="$(get_outputs)" || exit 0

laptop_is_active() {
  jq -e \
    --arg name "$LAPTOP_OUTPUT" \
    '.[] | select(.name == $name and .active == true)' \
    <<<"$OUTPUTS" >/dev/null
}

external_is_active() {
  jq -e \
    --arg name "$LAPTOP_OUTPUT" \
    '.[] | select(.name != $name and .active == true)' \
    <<<"$OUTPUTS" >/dev/null
}

case "$STATE" in
closed)
  if external_is_active; then
    # Docked: remove the internal screen from Sway's layout.
    swaymsg "output $LAPTOP_OUTPUT disable" >/dev/null
  elif ! laptop_is_active; then
    # Never leave Sway with zero active outputs.
    # logind can now suspend with eDP logically enabled.
    swaymsg "output $LAPTOP_OUTPUT enable" >/dev/null 2>&1 || true
  fi
  ;;

open)
  # In the normal undocked suspend path, eDP remains active,
  # so this block does nothing.
  if ! laptop_is_active; then
    # Small delay/retry helps if the dock or DRM connector
    # is still settling.
    sleep 0.5

    for _ in 1 2 3 4 5; do
      swaymsg "output $LAPTOP_OUTPUT enable" >/dev/null 2>&1 || true
      swaymsg "output $LAPTOP_OUTPUT power on" >/dev/null 2>&1 || true

      sleep 0.25
      OUTPUTS="$(get_outputs)" || continue

      laptop_is_active && break
    done
  fi
  ;;
esac
