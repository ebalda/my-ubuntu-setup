#!/usr/bin/env zsh

cd /usr/share/applications/
CUSTOM_ICONS_DIR="${HOME}/.custom_icons/"

DESKTOP_FILES=( "terminator" "google-chrome" "brave-browser")
ICONS_OLD=( "terminator" "google-chrome" "brave-browser")
ICONS_NEW=( "hyper.png" "chrome-aixbrain.svg" "chrome-personal.svg")

for i in 0 1; do
	sudo sed -i s+Icon="${ICONS_OLD[$i]}"+Icon="${CUSTOM_ICONS_DIR}${ICONS_NEW[$i]}"+g "${DESKTOP_FILES[$i]}.desktop"
done

# cd /var/lib/snapd/desktop/applications/
# sudo chmod +w gitkraken_gitkraken.desktop
# sudo sed -i s+Icon=gitkraken+Icon=${HOME}/.custom_icons/gitkraken.svg+g gitkraken_gitkraken.desktop
