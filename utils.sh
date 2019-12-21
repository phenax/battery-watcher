#!/bin/bash

BATTERIES=( /sys/class/power_supply/BAT*/uevent )

BAT_LOW=25;
BAT_CRITICAL=10;

lt() { (( $1 < $2 )); }
eq() { [ "$1" == "$2" ]; }

# Parse a battery property out
get_battery_property() {
  PROP=$1;
  awk "/$PROP\=/ {split(\$1, a, \"=\"); print a[2]}" "${BATTERIES[@]}";
} > /dev/null;

# Get battery properties
get_battery_percentage() { get_battery_property "POWER_SUPPLY_CAPACITY"; }
get_battery_status() { get_battery_property "POWER_SUPPLY_STATUS"; }

# Battery flags
is_battery_discharging() {
  STATUS=$(get_battery_status);
  echo "$STATUS";
  eq "$STATUS" "Discharging";
};
is_battery_low() { lt "$(get_battery_percentage)" "$BAT_LOW"; }
is_battery_critical() { lt "$(get_battery_percentage)" "$BAT_CRITICAL"; }

echo "$(is_battery_discharging && "yes" : "no")";

