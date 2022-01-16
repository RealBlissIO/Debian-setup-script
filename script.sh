printf '\033c'
echo "Welcome to Debian setup Script"
read -p "Did you setup and install doas? [y/n]" answer
if [[ $answer = y ]] ; then
  echo "Installing the required packages"
  doas apt install libx11-dev libxft-dev xinit libxinerama-dev build-essential git bspwm sxhkd picom rxvt-unicode alsa-utils vim feh
  echo "Setting up startx"
  touch "exec bspwm" >> /.xinitrc
  echo "Setting up the config folder"
  mkdir .config
  mkdir .config/bspwm
  mkdir .config/sxhkd
  cp /usr/share/doc/bspwm/examples/bspwmrc .config/bspwm/
  cp /usr/share/doc/bspwm/examples/sxhkdrc .config/sxhkd/
  
  
  
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
