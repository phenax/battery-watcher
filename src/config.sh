
# Messages
BAT_LOW_MSG="Low battery. Shove that charger in quick!";
BAT_CRITICAL_MSG="Shove that big charger in my port";

# (In seconds) Waiting time before checking for the battery status
POLL_INTERVAL=$(( 5 * 60 ));

SERVICES_DIR=/usr/lib/systemd/user;
SERVICE_NAME=battery-watcher.service;
INSTALL_DIR=/usr/lib/alpha-battery-watcher;
BINARY=/usr/bin/battery-watcher;

