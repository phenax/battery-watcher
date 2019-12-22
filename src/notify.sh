#!/bin/bash
# notify :: error|warn|message|info -> Message -> ()

APP_NAME="Battery";

# :: Message -> ()
show_nagbar() {
  i3-msg "exec i3-nagbar -m \"🔋 $APP_NAME: ${1}\"";
} > /dev/null;

# :: Message -> critical|normal|low -> ()
show_notification() {
  notify-send -u $2 "${1}" --app-name $APP_NAME;
} > /dev/null;

case "$1" in
  nag)       show_nagbar "$2" ;;
  warn)      show_notification "$2" "critical" ;;
  message)   show_notification "$2" "normal" ;;
  info)      show_notification "$2" "low" ;;
  *)         echo "Invalid notify type" ;;
esac;

