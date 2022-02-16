#!/bin/sh
printf '\033c'
echo "Welcome to Debian setup Script" 
echo "Testing internet connection "
ping -c 3 gnu.org 
echo "Installing the required packages" 
doas apt install libx11-dev libxft-dev xinit libxinerama-dev build-essential git picom alsa-utils vim feh 
echo "Setting up startx" 
cd $HOME 
touch .xinitrc 
echo "picom &" >> .xinitrc 
echo "Setting up the config folder" 
mkdir .config 
echo "exec dwm" >> .xinitrc 
mkdir my-files 
mkdir my-files/pics 
echo "feh --bg-fill --randomize ~/my-files/pics/*" >> .xinitrc
echo "setting up dmenu" 
cd .config/ 
git clone https://github.com/RealBlissIO/Dotfiles.git 
cp -r Dotfiles/config/ .
mv config/* .
cd dmenu/ 
doas make clean install 
cd .. 
cd dwm/ 
doas make clean install
cd $HOME
cp .config/Dotfiles/.xinitrc .
exit
