<p align="center"><a href="https://ibb.co/DzZFK8v"><img src="https://i.ibb.co/FmF170y/BLACKBUNTU-LOGO-2.png" alt="BLACKBUNTU-LOGO-2" border="0" width="50%" height="50%"></a></p>


This is a fully Flat Remix Darkest (Orange preferred but you can select other colours via Gnome 50 Settings in Theme) themed installation build script to convert Ubuntu 26.04 LTS installation to Blackbuntu 26.04. It is recommended to execute on a clean installation.  

Download the latest Ubuntu ISO from here: ` https://ubuntu.com/download/desktop `

_Note this script and theme will not work correctly on older builds of ubuntu, such as 22.04 LTS, check this repo for one for 22.04 - https://github.com/andrewpayne68/BLACKBUNTU.2204_

Includes Thorium Browser, Brave Browser, Tweaks, GDM Settings, Gedit (Matrix Themed) and Variety Wallpaper Changer, as well as many other open source OSINT and PenTest applications.

BONUS - Includes https://c-nergy.be/blog/?p=20304 "Ubuntu- Change-Gdm-Background script Version 4.0" which has been modded to support Gnome 50/ Ubuntu 26.04 and will run at the end of the build.sh script. Standalone included in repo files.

Transparent Top Panel (for Gnome 50)
-
After installation - obtain and activate the following Extension to enable transparent top panel: https://github.com/lamarios/gnome-shell-extension-transparent-top-bar

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
![image-1](https://github.com/andrewpayne68/blackbuntu2404/blob/main/Blackbuntu-desktop.png)



