#!/bin/bash
# * install terminator
sudo apt-get install terminator
# * install gitkraken
sudo snap install gitkraken

# * install brave
sudo apt install apt-transport-https curl

curl -s https://brave-browser-apt-release.s3.brave.com/brave-core.asc | sudo apt-key --keyring /etc/apt/trusted.gpg.d/brave-browser-release.gpg add -
echo "deb [arch=amd64] https://brave-browser-apt-release.s3.brave.com/ stable main" | sudo tee /etc/apt/sources.list.d/brave-browser-release.list
sudo apt update
sudo apt install brave-browser

# * install google chrome
wget https://dl.google.com/linux/direct/google-chrome-stable_current_amd64.deb
sudo apt install ./google-chrome*.deb

# * customize browser icons
$HOME/.custom_icons/link_icons.sh

# * install git
sudo apt-get install git

# * install oh-my-bash
sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmybash/oh-my-bash/master/tools/install.sh)"
sudo apt-get install fonts-powerline
sudo cp -avfR ./home/.* $HOME

# * use lightdm instead of gdm3
sudo apt-get install lightdm
sudo apt-get install lightdm-gtk-greeter-settings
sudo dpkg-reconfigure lightdm

# * reboot
reboot
