#!/bin/bash

BAT_LOW_MSG="Low battery. Shove that charger in quick!";
BAT_CRITICAL_MSG="Shove that big charger in my port";

POLL_INTERVAL=$(( 3 * 60 ));

source ./utils.sh;

# alias
notify() { ./notify.sh "$@"; }

# Notify if battery low
check() {
  if is_battery_discharging; then
    is_battery_low       && notify "warn" $BAT_LOW_MSG;
    is_battery_critical  && notify "error" $BAT_CRITICAL_MSG;
  fi;
}

show_battery_percentage() {
  notify "info" ""
}

# Loop for checking if battery is low
start_polling() {
  while true; do
    check;
    sleep $POLL_INTERVAL;
  done;
}

case "$1" in
  get)    echo $(get_battery_percentage) ;;
  show)   show_battery_perc ;;
  once)   check ;;
  watch)  start_polling ;;
  *)      echo "Usage: battery.sh (watch|get)" ;;
esac;

