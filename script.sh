#!/bin/sh
printf '\033c'
echo "Welcome to Debian setup Script" 
echo "Testing internet connection "
ping -c 3 gnu.org && 
echo "Installing the required packages" &&
doas apt install libx11-dev libxft-dev xinit libxinerama-dev build-essential git \
  picom alsa-utils pipewire pipewire-pulse pipewire-alsa vim feh fonts-jetbrains-mono \
  fonts-noto-cjk fonts-noto dunst alacritty ;
cd $HOME &&
echo "Setting up the config folder" &&
mkdir .config  &&
cd .config/ &&
git clone https://github.com/shaolingit/Dotfiles.git &&
mv .config/Dotfiles/config/alacritty . &&
mv Dotfiles/suckless-old/* . &&
sudo make clean install -C dwm/ || echo "dwm failed to compile"
sudo make clean install -C dmenu/  || echo "dmenu failed to compile"
sudo make clean install -C slstatus/ || echo "slstatus failed to compile"
cd $HOME && 
mv .config/Dotfiles/config/bashrc .bashrc &&
mv .config/Dotfiles/config/xinitrc .xinitrc
exit
