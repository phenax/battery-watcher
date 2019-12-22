#!/bin/bash

# Imports
source ./config.sh;
source ./utils.sh;
notify() { ./notify.sh "$@"; }

# Notify if battery low
check() {
  if is_battery_discharging; then
    is_battery_low       && notify "warn" $BAT_LOW_MSG;
    is_battery_critical  && notify "error" $BAT_CRITICAL_MSG;
  fi;
}

# Get battery status text
get_status_text() { echo "$(get_battery_status) $(get_battery_percentage)"; }

# Loop for checking if battery is low
start_polling() {
  while true; do
    check;
    sleep $POLL_INTERVAL;
  done;
}

case "$1" in
  get)    echo $(get_status_text) ;;
  show)   notify "info" "$(get_status_text)" ;;
  once)   check ;;
  watch)  start_polling ;;
  *)      echo "Usage: battery.sh (watch|get)" ;;
esac;

