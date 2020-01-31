#!/bin/bash
cd /usr/share/applications/
CUSTOM_ICONS_DIR="${HOME}/.custom_icons/"

DESKTOP_FILES=( "google-chrome" "brave-browser")
ICONS_OLD=( "google-chrome" "brave-browser")
ICONS_NEW=( "chrome-aixbrain" "chrome-personal")

for i in 0 1; do
	sudo sed -i s+Icon="${ICONS_OLD[$i]}"+Icon="${CUSTOM_ICONS_DIR}${ICONS_NEW[$i]}".svg+g "${DESKTOP_FILES[$i]}.desktop"
done

cd /var/lib/snapd/desktop/applications/
sudo chmod +w gitkraken_gitkraken.desktop
sudo sed -i s+Icon=gitkraken+Icon=${HOME}/.custom_icons/gitkraken.svg+g gitkraken_gitkraken.desktop

# * Change terminators icon
sudo  cp ${CUSTOM_ICONS_DIR}terminator.png /usr/share/icons/hicolor/48x48/apps/terminator.png
