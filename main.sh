#!/bin/bash
#
echo "Hello and welcome to BlissIO's Debian setup script"
echo "Checking internet...."
ping -c 1 gnu.org > /dev/null 2>&1
if [ $? -ne 0 ]; then
	echo "You are no connected to the internet. Aborting now..."
	exit 1
done
fi
else
	echo "checking for root access"
	if [[ $EUID -ne 0 ]]; then
    		echo "This script must be run as root."
    		exit 1
	fi
	else
		apt install libx11-dev libxft-dev xinit libxinerama-dev build-essential git \
  		picom alsa-utils pipewire pipewire-pulse pipewire-alsa vim feh fonts-jetbrains-mono \
  		fonts-noto-cjk fonts-noto dunst alacritty ;
		read -p "Would you like to install a desktop enviroment/window manager now [y/n]" ans
		if [[ an == y ]]
			echo "Select a desktop environment:"
			options=("XFCE" "KDE" "GNOME" "BSPWM" "AWESOME" "i3")
	
			select option in "${options[@]}"; do
			    case $option in
			        "XFCE")
			            apt-get install task-xfce-desktop
				    default_target=$(systemctl get-default)
					if [[ $default_target != "graphical.target" ]]; then
					    systemctl set-default graphical.target
					    echo "Default target set to graphical.target."
					else
					    echo "Default target is already set to graphical.target."
					fi
			            break
			            ;;
			        "KDE")
			            apt-get install kde-plasma-desktop
					default_target=$(systemctl get-default)
					if [[ $default_target != "graphical.target" ]]; then
					    systemctl set-default graphical.target
					    echo "Default target set to graphical.target."
					else
					    echo "Default target is already set to graphical.target."
					fi
				    break
				    ;;
		        	"GNOME")
					apt-get install gnome
					default_target=$(systemctl get-default)
					if [[ $default_target != "graphical.target" ]]; then
					    systemctl set-default graphical.target
					    echo "Default target set to graphical.target."
					else
					    echo "Default target is already set to graphical.target."
					fi
		            		break
		            		;;
				"AWESOME")
					apt-get install awesome alacritty picom
		            		break
		            		;;
				"i3")
					apt-get install i3 alacritty picom
		            		break
		            		;;
		        	"BSPWM")
		            		apt-get install bspwm sxhkd polybar alacritty picom
		            		break
		            		;;
		        	*)
		            	echo "Invalid option. Please select a valid option."
				;;
			    esac
			done

		fi
	fi

fi
