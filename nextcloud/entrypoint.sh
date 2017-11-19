#!/bin/bash
set -e

# Set default INSTALL_PATH (to the default Apache2 directory)
if [ -z "$INSTALL_PATH" ]; then
	INSTALL_PATH=/var/www/html
fi

# Install Nextcloud if not already installed
if [ ! -e $INSTALL_PATH ] || [ $(ls $INSTALL_PATH | wc -l) -eq 0 ]; then
	echo "[Entrypoint] Nextcloud doesn't seem to be installed..."
	if [ -z "$INSTALL_VERSION" ]; then
		echo "Environment variable INSTALL_VERSION is required for the installation."
		echo "Skipped installation."
	else
		nextcloud-download-and-extract "$INSTALL_VERSION" "$INSTALL_PATH"
		echo "Fixing permissions..."
		nextcloud-fix-permissions $INSTALL_PATH
		echo "Nextcloud installed !"
	fi
fi

exec "$@"
