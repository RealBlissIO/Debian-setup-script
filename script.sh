#!/bin/sh
printf '\033c'
echo "Welcome to Debian setup Script" 
echo "Testing internet connection "
ping -c 3 lukesmith.xyz
read -p "Did you setup and install doas? [y/n]" answer 
if [[ $answer = y ]] ; then
  echo "Installing the required packages" 
  doas apt install libx11-dev libxft-dev xinit libxinerama-dev build-essential git bspwm sxhkd picom rxvt-unicode alsa-utils vim feh 
  echo "Setting up startx"
  cd $HOME
  touch .xinitrc
  echo "exec bspwm" >> .xinitrc
  echo "Setting up the config folder"
  mkdir .config
  mkdir .config/bspwm
  mkdir .config/sxhkd
  cp /usr/share/doc/bspwm/examples/bspwmrc .config/bspwm/
  cp /usr/share/doc/bspwm/examples/sxhkdrc .config/sxhkd/
  echo "Setting up bspwm and sxhkd Dotfiles"
  mkdir .config/bspwm
  mkdir .config/sxhkd
  cp /usr/share/doc/bspwm/examples/bspwmrc .config/bspwm/
  cp /usr/share/doc/bspwm/examples/sxhkdrc .config/sxhkd/
  echo "#AutoStart" >> .config/bspwm/bspwmrc
  echo "picom &" >> .config/bspwm/bspwmrc
  echo "xrdb .Xresources" >> .config/bspwm/bspwmrc
  mkdir Pix
  mkdir Pix/Wall
  echo "feh --bg-scale --randomize ~/Pix/Wall/*" >> .config/bspwm/bspwmrc
  echo "setting up dmenu"
  mkdir Downloads
  cd Downloads/
  git clone https://git.suckless.org/dmenu
  cd dmenu/
  doas make clean install
  cd
  echo "Cloning Dotfiles"
  git clone https://github.com/RealBlissIO/Dotfiles
  cp Dotfiles/.Xresources ..
  cd Dotfiles/
  echo  "Installing the fonts and setting up urxvt"
  doas dpkg -i fonts-inconsolata_001.010-6_all.deb
  cd
  cp Downloads/Dotfiles/urxvt .config
  echo "Cloning Dotfiles"
  git clone https://github.com/RealBlissIO/Dotfiles
  cp Dotfiles/.Xresources ..
  cd Dotfiles/
  echo  "Installing the fonts and setting up urxvt"
  doas dpkg -i fonts-inconsolata_001.010-6_all.deb
  cd
  cp Downloads/Dotfiles/urxvt .config
  echo "We are done with the Dotfiles yay"
  read -p "Do you want to install the brave browser? [y/n]" answer
  if [[ $answer = y ]] ; then
    echo "Installing the brave browser"
    
    doas apt install apt-transport-https curl

    doas curl -fsSLo /usr/share/keyrings/brave-browser-archive-keyring.gpg https://brave-browser-apt-release.s3.brave.com/brave-browser-archive-keyring.gpg

    echo "deb [signed-by=/usr/share/keyrings/brave-browser-archive-keyring.gpg arch=amd64] https://brave-browser-apt-release.s3.brave.com/ stable main"|doas tee /etc/apt/sources.list.d/brave-browser-release.list

    doas apt update
    
    doas apt install brave-browser
  fi
fi
if [[ $answer = n ]] ; then
  echo "install doas by being root using su then put the password in and install the doas binary"
  echo "later edit the /etc/doas.conf file by placing permit nameofuser as root"
  echo "once you are done rerun this script to continue"
  echo "Debian Installer shutting down"
fi
exit
