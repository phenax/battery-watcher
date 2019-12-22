#!/bin/bash

# Imports
source ./src/config.sh;

SERVICE_PATH="$SERVICES_DIR/$SERVICE_NAME";

# Uninstall
if [ "$1" == "uninstall" ]; then
  rm -rf $INSTALL_DIR;
  rm -f $BINARY;
  rm -f $SERVICE_PATH;
  echo "Uninstalled battery-watcher";
  exit 0;
fi

script_contents="
#!/bin/bash\n
cd $INSTALL_DIR && ./battery.sh \"\$@\";
";

# Copy contents files to install directory
echo "Copying files..." &&
mkdir $INSTALL_DIR &&
cp src/* $INSTALL_DIR/ &&

# Create binary executable
echo "Creating binary..." &&
echo -e $script_contents > $BINARY &&
chmod +x $BINARY &&

## Create service
echo "Creating service..." &&
cp ./$SERVICE_NAME $SERVICES_DIR &&
chmod +x $SERVICE_PATH;

