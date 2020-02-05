#!/bin/bash
# * install terminator
sudo apt-get install terminator

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

# * add aliases to bashrc
cat append_to_bashrc.txt >> $HOME/.bashrc
