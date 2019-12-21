#!/bin/bash

BAT_LOW=25;
BAT_CRITICAL=41;

BAT_LOW_MSG="Low battery. Shove that charger in quick!";
BAT_CRITICAL_MSG="Shove that big charger in my port";

APP_NAME="Battery";

POLL_INTERVAL=$(( 3 * 60 ));

BATTERIES=( /sys/class/power_supply/BAT*/uevent )

COMMAND="$1"

lt() { (( $1 < $2 )); }

# Parse out the battery percentage
get_battery_percentage() {
  awk '/POWER_SUPPLY_CAPACITY\=/ {split($1, a, "="); print a[2]}' "${BATTERIES[@]}";
}

# Notification methods
show_nagbar() {
  i3-msg "exec i3-nagbar -m \"🔋 $APP_NAME: ${1}\"";
} > /dev/null;
show_notification() {
  notify-send -u critical "${1}" --app-name $APP_NAME;
} > /dev/null;

# Battery flags
is_battery_discharging() {
    grep STATUS=Discharging "${BATTERIES[@]}" && return 0 || return 1;
} > /dev/null;
is_battery_low() { lt "$(get_battery_percentage)" "$BAT_LOW"; }
is_battery_critical() { lt "$(get_battery_percentage)" "$BAT_CRITICAL"; }


# Loop for checking if battery is low
start_polling() {
  while true; do
    if is_battery_discharging; then
      is_battery_low && show_notification $BAT_LOW_MSG;
      is_battery_critical && show_nagbar $BAT_CRITICAL_MSG;
    fi;
    sleep $POLL_INTERVAL;
  done;
}

case "$COMMAND" in
  get)
    echo $(get_battery_percentage);
    ;;
  watch)
    echo "Starting";
    ;;
  *)
    echo "Usage: battery.sh (watch|get)";
    ;;
esac;

