<p align="center"><a href="https://ibb.co/DzZFK8v"><img src="https://i.ibb.co/FmF170y/BLACKBUNTU-LOGO-2.png" alt="BLACKBUNTU-LOGO-2" border="0" width="50%" height="50%"></a></p>


This is a fully Flat Remix Darkest (Orange preferred but you can select other colours via Gnome 50 Settings in Theme) themed installation build script to convert Ubuntu 26.04 LTS installation to Blackbuntu 26.04. It is recommended to execute on a clean installation.  

Download the latest Ubuntu ISO from here: ` https://ubuntu.com/download/desktop `

Includes Thorium Browser, Brave Browser, Tweaks, GDM Settings, Gedit (Matrix Themed) and Variety Wallpaper Changer, as well as many other open source OSINT and PenTest applications.

BONUS - Includes https://c-nergy.be/blog/?p=20304 "Ubuntu- Change-Gdm-Background script Version 4.0" which has been modded to support Gnome 50/ Ubuntu 26.04 and will run at the end of the build.sh script. Standalone included in repo files.


Installation Script
-

```
sudo apt-get -y install git
```
```
git clone https://github.com/andrewpayne68/blackbuntu2604.git
```
```
cd blackbuntu2604
```
```
tar -xf blackbuntu-2604.tar.xz
```
```
./build.sh
```

OR run the all-in-one bash command
```
sudo apt-get -y install git && git clone https://github.com/andrewpayne68/blackbuntu2604.git && cd blackbuntu2604 && tar -xf blackbuntu-2604.tar.xz && ./build.sh
```
\
\
After the first reboot, run Nala to update Blackbuntu
-
```
sudo nala update && sudo nala upgrade -y
```

\
\
Screenshot
-
\
![image-1](https://github.com/andrewpayne68/blackbuntu2604/blob/main/blackbuntu-2604-desktop.png)

\
\
\
Additional Items/Fixes for Gnome 50, Login and Setting Default Terminal app

\
Transparent Top Panel (for Gnome 50)
-
After installation - obtain and activate the following Extension to enable transparent top panel: https://github.com/lamarios/gnome-shell-extension-transparent-top-bar

\
GDM
-
Set GDM accent color to match GNOME Shell (orange) add these lines to /etc/gdm3/greeter.dconf-defaults:

    [org/gnome/desktop/interface]
    accent-color='orange'

Set GDM accent color to match GNOME Shell (orange) using single Command Line:

    echo "[org/gnome/desktop/interface]" | sudo tee -a /etc/gdm3/greeter.dconf-defaults && echo "accent-color='orange'" | sudo tee -a /etc/gdm3/greeter.dconf-defaults

\
Terminal/Kitty
-
Set kitty as the default Terminal app in Gnome 50/Ubuntu 26.04 LTS in a single command line:

    sudo ln -s ~/.local/kitty.app/bin/kitty /usr/bin/kitty~ && gsettings set org.gnome.desktop.default-applications.terminal exec kitty

\
User Extensions Installed:
-
![image-1](https://github.com/andrewpayne68/blackbuntu2604/blob/main/user-extensions.png)

\
Ubuntu Dock: add true autohide option to default session
-

```
gsettings set org.gnome.shell.extensions.dash-to-dock intellihide false
```

After that, turning on autohide option in System Settings will activate `true autohide` instead of the default intellihide.

To get things back just run:
```
gsettings set org.gnome.shell.extensions.dash-to-dock intellihide true
```
\
Install Flatpak
-

To install Flatpak on Ubuntu 18.10 (Cosmic Cuttlefish) or later, open the Terminal app and run:

    sudo apt install flatpak

Install GNOME Software Flatpak plugin

The GNOME Software plugin makes it possible to install apps without needing the command line. To install, run:

    sudo apt install gnome-software-plugin-flatpak

Note: Ubuntu distributes GNOME Software as a Snap in versions 20.04 to 23.04, and replaced it with App Center in 23.10 and newer—neither of which support installing Flatpak apps. Installing the Flatpak plugin will also install a deb version of GNOME Software, resulting in two "Software" apps being installed at the same time on Ubuntu 20.04 to 23.04, and a single new "Software" app on Ubuntu 23.10 and newer.

Add the Flathub repository

Flathub is the best place to get Flatpak apps. To enable it, download and install the  or run:

    flatpak remote-add --if-not-exists flathub https://dl.flathub.org/repo/flathub.flatpakrepo

Install & Configure Flatpak Single Command:

    sudo apt install flatpak -y && sudo apt install gnome-software-plugin-flatpak -y && flatpak remote-add --if-not-exists flathub https://dl.flathub.org/repo/flathub.flatpakrepo



