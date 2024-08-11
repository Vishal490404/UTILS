#!/bin/bash

total_steps=12
progress=0

update_progress() {
    local increment=${1:-1}
    if [ $increment -eq 1 ]; then
        let progress++
    fi
    let filled_slots=progress*20/total_steps
    bar=""
    for ((i=0; i<$filled_slots; i++)); do
        bar="${bar}#"
    done
    for ((i=filled_slots; i<20; i++)); do
        bar="${bar}-"
    done
    let percentage=progress*100/total_steps
    echo -ne "\r[${bar}] ${percentage}% "
}

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
	update_progress 1
}

install_cinnamon(){
	echo "Installing Desktop Environment...This may take a while..."
	sudo apt install cinnamon -y&> /dev/null
	update_progress 1
}
install_gnome_tweaks(){
	echo "Installing Gnome Tweaks..."
	sudo apt install gnome-tweaks -y&> /dev/null
	update_progress 1
}
install_gnome_shell(){
	echo "Installing Gnome Shell..."
	sudo apt install gnome-shell-extension-manager -y&> /dev/null
	update_progress 1
}
check_python(){
	echo "Checking Python..."
	update_progress 0
	python3 --version &> /dev/null
	if [ $? -eq 0 ]; then
		echo "Python is installed"
		update_progress 1
	else
		echo "Python is not installed"
		update_progress 0
		echo "Installing Python..."
		update_progress 0
		sudo apt install python3 -y&> /dev/null
		update_progress 1
	fi
}
install_pip(){
	echo "Installing pip..."
	sudo apt install python3-pip -y&> /dev/null
	update_progress 1
	sudo apt install pipx -y&> /dev/null
	update_progress 1
}
install_git(){
	echo "Installing Git..."
	sudo apt install git -y&> /dev/null
	update_progress 1
}
# install_vscode(){
# 	echo "Installing Visual Studio Code..."
# 	sudo apt install code &> /dev/null
# }
install_effect(){
	echo "Installing magic effects..."
	pipx install terminaltexteffects &> /dev/null
	update_progress 1
	pipx ensurepath &> /dev/null
	
}
install_figlet(){
	echo "Installing figlet..."
	sudo apt install figlet -y&> /dev/null
	update_progress 1
}

install_lolcat(){
	echo "Installing lolcat..."
	sudo apt install lolcat -y&> /dev/null
	update_progress 1
}
install_essential(){
	echo "Installing other dependancies..."
	sudo apt install curl wget gcc g++ -y&> /dev/null
	update_progress 1
} 

install_phi(){
	echo "Installing hacking software..."
	wget -P $dir https://github.com/aunchagaonkar/installdeps/releases/download/init/eDEX-UI-Linux-x86_64.AppImage &> /dev/null
	chmod +x $dir/eDEX-UI-Linux-x86_64.AppImage 
	echo "alias netninja=\"\$dir/eDEX-UI-Linux-x86_64.AppImage\"" >> ~/.bashrc
	update_progress 1
}
install_done(){
	echo "Installation done"
}
# Function starts here
# Check internet connection
check_internet
# Display initial state
echo -n "[--------------------] 0% "

update_repos
#make a temp dir
mkdir $(pwd)/-/
dir=$(pwd)/-/

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
	install_phi
	install_done
}

install_deps