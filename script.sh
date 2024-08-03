#!/bin/bash

if [ "$EUID" -ne 0 ]; then
  echo "Please run as root"
  echo "Try sudo bash script.sh"
  exit
fi
check_internet(){
	echo "Checking internet connection.."
	ping -c 1 google.com &> /dev/null
	if [ $? -eq 0 ]; then
		echo "You are connected to the internet"
	else
		echo "Check your internet connection"
		echo "Connect to WCE Wifi 6"
		echo "Password: Walchand@123"
		echo "Enter creadentials on the login page provided by the volunteers"
		echo "After connecting to the internet, run the script again"
		exit
	fi
}

update_repos(){
	echo "Updating repos..."
	sudo apt update &> /dev/null
}

install_cinnamon(){
	echo "Installing Desktop Environment..."
	sudo apt install cinnamon &> /dev/null
}
install_gnome_tweaks(){
	echo "Installing Gnome Tweaks..."
	sudo apt install gnome-tweaks &> /dev/null
}
install_gnome_shell(){
	echo "Installing Gnome Shell..."
	sudo apt install gnome-shell-extension-manager &> /dev/null
}
check_python(){
	echo "Checking Python..."
	python3 --version
	if [ $? -eq 0 ]; then
		echo "Python is installed"
	else
		echo "Python is not installed"
		echo "Installing Python..."
		sudo apt install python3 &> /dev/null
	fi
}
install_pip(){
	echo "Installing pip..."
	sudo apt install python3-pip &> /dev/null
	sudo apt install pipx &> /dev/null
}
install_git(){
	echo "Installing Git..."
	sudo apt install git &> /dev/null
}
# install_vscode(){
# 	echo "Installing Visual Studio Code..."
# 	sudo apt install code &> /dev/null
# }
install_effect(){
	echo "Installing magic effects..."
	pipx install terminaltexteffects &> /dev/null
	pipx ensurepath &> /dev/null
}
install_figlet(){
	echo "Installing figlet..."
	sudo apt install figlet &> /dev/null
}
install_lolcat(){
	echo "Installing lolcat..."
	sudo apt install lolcat &> /dev/null
}
install_essential(){
	echo "Installing other dependancies..."
	sudo apt install curl wget &> /dev/null
}
check_internet
update_repos
install_deps(){
	install_essential
	install_git
	install_cinnamon
	install_gnome_tweaks
	install_gnome_shell
	check_python
	install_pip
	# install_vscode
	install_effect
	install_figlet
	install_lolcat
}

install_deps