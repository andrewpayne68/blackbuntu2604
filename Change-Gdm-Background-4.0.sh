#!/bin/bash
##########################################################################
# Script_Name : Change-Gdm-Background-4.0.sh                             # 
# Description : Change background image of the GDM Login screen          #
# on ubuntu 22.04,24.04,25.04,25.10                                      #
# Date : October 2025                                                    #
# written by : Griffon                                                   #
# Web Site :https://www.c-nergy.be - https://www.c-nergy.be/blog         #    
# Version : 4.0                                                          #
# History : 4.0 - Adding Support Ubuntu 25.10                            #
#         :     - Removing support Ubuntu 24.10                          #
#         : 3.9 - Adding support Ubuntu 25.04                            #
#         :     - Removing support to Ubuntu 20.04 (End Std Support)     #   
#         :     - Minor Code Update                                      #
#         : 3.8 - Adding support to Ubuntu 24.10                         #   
#         :     - Fixing Zenity Sizing DialogBox                         #
#         :     - Minor code update                                      #      
#         : 3.7 - Adding support to Ubuntu 24.04                         #
#               - Remove Support Ubuntu 23.04 and 23.10                  #
#         : 3.6 - Adding support to Ubuntu 23.XX                         #
#         :     - Remove Support Ubuntu 18.04 (End of Standard Support)  #
#         :     - Remove Support Ubuntu 22.10 (End of Life)              #
#         : 3.5 - Adding Support to Ubuntu 22.10                         #
#         : 3.5 - Remove Support End of Life Ubuntu                      #
#         : 3.4 - Adding Support to Ubuntu 22.04                         #
#         : 3.3 - Adding Support to Ubuntu 21.10                         #
#               - Removing Support to Ubuntu 20.10                       # 
#         : 3.2 - Adding Support to Ubuntu 21.04                         #
#               - Updating Code Picture background                       #
#           3.1 - Adding Support to Ubuntu 20.10                         #
#           3.0 - Adding Support to Ubuntu 20.04                         #
#               - New Code structure                                     #
#               - Added Solid Color Palette GUI                          #
#           2.0 - Updated Version to support 17.10,18.04,18.10           #   
#           1.0 - Initial Release Ubuntu 17.10                           # 
#                                                                        #
# Disclaimer : Script provided AS IS. Use it at your own risk....        #
#              You can use this script and distribute it as long as      #
#              credits are kept in place and unchanged                   #
#                                                                        # 
##########################################################################
#---------------------------------------------------#
# Variables and Constants                           #
#---------------------------------------------------#

#--Automating Script versioning 
ScriptVer="4.0"
gdmpath="gdm"
version=$(lsb_release -sd)
#---------------------------------------------------#
# Script Version information Displayed              #
#---------------------------------------------------#

echo
/bin/echo -e "\e[1;36m   
  !----------------------------------------------------------------!
  !             Change-Gdm-Background script - Ver. $ScriptVer            !           
  !                Written by Griffon - Oct.  2025                 !  
  !                      www.c-nergy.be                            ! 
  !----------------------------------------------------------------!
\e[0m"
/bin/echo -e "\e[1;38m   
  !----------------------------------------------------------------!
  !                      Disclaimer                                !
  !   !! Script provided AS IS. Use it at your own risk.!!         !
  !----------------------------------------------------------------!
\e[0m"
echo

#--------------------------------------------------------------------------#
# -----------------------Function Section - DO NOT MODIFY -----------------#
#--------------------------------------------------------------------------#
#---------------------------------------------------#
# Function 0  - check for supported OS version  ....#
#---------------------------------------------------#

check_os()
{
echo
/bin/echo -e "\e[1;33m   |-| Detecting Ubuntu version        \e[0m"

#--Initialize variable to check if OS supported or not
oschk=""

#--Define array of Supported OS 
array=("Ubuntu 22.04" "Ubuntu 24.04" "Ubuntu 25.10" "Ubuntu 25.04" "Ubuntu 26.04")

for element in "${array[@]}"; do
   
  if [[ $version == *"$element"* ]]; then
       #-- Supported OS
       oschk=Supported
   fi  
done

if [[ "$oschk" == "Supported" ]]
then 
    if [[ "$version" == *"Ubuntu 22.04"* ]]
    then
      /bin/echo -e "\e[1;32m       |-| Ubuntu Version : $version\e[0m"
      call_gui_choice
      gdm_update
      gdm_compile
   else  
      /bin/echo -e "\e[1;32m       |-| Ubuntu Version : $version\e[0m"
      call_gui_choice
      gdm_update
      user_login_change
      gdm_compile
   fi
else 



      call_gui_choice
      gdm_update
      gdm_compile



echo    
exit
fi  
}

#--------------------------------------------------------------------#
# Function 1  - Display GUI for Change Login script                  #
#--------------------------------------------------------------------#

call_gui_choice(){

#------ Selection Dialog Box Displayed ----------------------------#
echo
/bin/echo -e "\e[1;33m   |-| Starting Wizard Interface        \e[0m"

cbxChoice=$(zenity  --list \
--height=400 \
--title="Login Screen Background Changer" \
--text "What do you want to do ?" \
--radiolist \
--column "Choice" \
--column "Description" \
FALSE "Solid color as background" \
FALSE "Picture as background" \
FALSE "Revert back to default" 2>/dev/null) 

#---------Check which option has been selected - Color/picture/Nothing------#

if [[ $cbxChoice = "Solid color as background" ]];
then

   /bin/echo -e "\e[1;32m       |-| Solid color selected..Proceeding\e[0m"
   selectcolor=$(zenity --color-selection --show-palette 2>/dev/null)
   if [ -z "$selectcolor" ]
   then
	/bin/echo -e "\e[1;31m       |-| No color has been chosen..Exiting\e[0m"       
 	exit 
   else 
      /bin/echo -e "\e[1;32m       |-| Solid color ........ : $selectcolor \e[0m"  	
   fi 
elif  [[ $cbxChoice = "Revert back to default" ]];
then
   /bin/echo -e "\e[1;31m       |-| Resetting Ubuntu default settings\e[0m"
   sudo update-alternatives --quiet --set $gdmpath-theme.gresource /usr/share/gnome-shell/theme/Yaru/gnome-shell-theme.gresource
   call_gui_rboot
   echo
elif  [[ $cbxChoice = "Picture as background" ]];
then
   /bin/echo -e "\e[1;32m       |-| Picture Selected...Proceeding\e[0m"  
   pix=$(zenity --file-selection --title="select the new login image" 2>/dev/null)
   if [ $? -eq 1 ]
   then
   	/bin/echo -e "\e[1;31m       |-| No Image Selected...Exiting\e[0m"  
        echo
	exit 
   else
	
	#--Get the File Name only not the full path -----## 
	fname=$(basename "$pix")
 	
   fi
else
	/bin/echo -e "\e[1;31m       |-| No option Selected...Exiting\e[0m" 
	echo
	exit 

fi

}

#--------------------------------------------------------------------#
# Function 2  - Reboot function                                      #
#--------------------------------------------------------------------#

call_gui_rboot(){

cbxReboot=$(zenity --list \
--height=400 \
--title="Restart GDM Service or Reboot ?" \
--text "Select which option is best for you?" \
--radiolist \
--column "Choice" \
--column "Description" \
FALSE "Reboot Now (Recommended)" \
FALSE "Restart GDM service" 2>/dev/null) 


#---------Check which option has been selected - Color/picture/Nothing------#

if [[ $cbxReboot = "Reboot Now (Recommended)" ]];
then

	 /bin/echo -e "\e[1;32m       |-| want to reboot....;:-)   \e[0m"
	 sudo reboot
	 
elif [[ $cbxReboot  = "Restart GDM service" ]];
then
/bin/echo -e "\e[1;32m       |-| Restart GDM service....;:-)   \e[0m"
 	sudo service gdm restart
else
	/bin/echo -e "\e[1;31m       |-| Nothing here..... \e[0m" 
	echo
	exit 

fi
}

#--------------------------------------------------------------------#
# Function 3  - Update css file on Ubuntu 20.04 or later             #
#--------------------------------------------------------------------#

gdm_common()
{
# Step 1 - Install prereqs for compilation later on
sudo apt-get -y install libglib2.0-dev-bin
sudo apt-get -y install libxml2-utils

#--Define some Variable
workdir="${HOME}/shell-theme"
xmlfile=${workdir}/custom.gresource.xml

echo
/bin/echo -e "\e[1;33m   |-| Creating Directory Structure        \e[0m"

if [ ! -d ${workdir} ]; then
	mkdir -p ${workdir}
fi

if [[ ! -d ${workdir}/Yaru ]]; then	
	mkdir -p ${workdir}/Yaru
fi

if [[ ! -d ${workdir}/Yaru-dark ]]; then	
	mkdir -p ${workdir}/Yaru-dark
fi

#Addition to support Ubuntu 21.04
if [[ ! -d ${workdir}/Yaru-light ]]; then	
	mkdir -p ${workdir}/Yaru-light
fi

if [[ ! -d ${workdir}/icons ]]; then	
	mkdir -p ${workdir}/icons
fi

if [[ ! -d ${workdir}/icons/scalable ]]; then	
	mkdir -p ${workdir}/icons/scalable
fi

if [[ ! -d ${workdir}/icons/scalable/actions ]]; then		
	mkdir -p ${workdir}/icons/scalable/actions
fi
if [[ ! -d ${workdir}/icons/scalable/status ]]; then		
	mkdir -p ${workdir}/icons/scalable/status
fi

echo
/bin/echo -e "\e[1;33m   |-| Creating xml file for compilation step       \e[0m"
bash -c "cat >"$xmlfile <<EOF
<?xml version="1.0" encoding="UTF-8"?>
<gresources>
 <gresource prefix="/org/gnome/shell/theme">
EOF

echo
/bin/echo -e "\e[1;32m       |-| Populate xml file...    \e[0m"   

#--Extract Resources -- Important location 
gst=/usr/share/gnome-shell/theme/Yaru/gnome-shell-theme.gresource
for r in `gresource list $gst`; do
	
       	gresource extract $gst $r >$workdir/${r#\/org\/gnome\/shell\/theme/} 
		if [ $? -eq 0 ]
		then
			echo "	<file>"${r#\/org\/gnome\/shell\/theme/}"</file>" >>$xmlfile
		fi
done

#Close the file 
echo "</gresource>" >>$xmlfile
echo "</gresources>" >>$xmlfile

}

#--------------------------------------------------------------------#
# Function 4  - GDM Compilation Function                             #
#--------------------------------------------------------------------#

gdm_compile()
{

/bin/echo -e "\e[1;32m       |-| Compile Resource File...\e[0m"   
cd ${workdir}
glib-compile-resources custom.gresource.xml
echo

/bin/echo -e "\e[1;33m |-| Create new Theme Folder... \e[0m"
if [ ! -d "/usr/share/gnome-shell/theme/custom" ]; then
	sudo mkdir /usr/share/gnome-shell/theme/custom
else
/bin/echo -e "\e[1;32m       |-| Folder exists...Proceeding  \e[0m"   
fi

/bin/echo -e "\e[1;32m       |-| Copy new gresource file...\e[0m"   
sudo cp ${workdir}/custom.gresource /usr/share/gnome-shell/theme/custom
/bin/echo -e "\e[1;32m       |-| Copy picture to new theme folder...\e[0m"   
echo
/bin/echo -e "\e[1;33m |-| Applying Changes... \e[0m"
/bin/echo -e "\e[1;32m       |-| redirect to new theme folder...\e[0m"   
echo
sudo update-alternatives --quiet --install /usr/share/gnome-shell/$gdmpath-theme.gresource $gdmpath-theme.gresource /usr/share/gnome-shell/theme/custom/custom.gresource 0
sudo update-alternatives --quiet --set $gdmpath-theme.gresource /usr/share/gnome-shell/theme/custom/custom.gresource

echo
/bin/echo -e "\e[1;33m |-| Rebooting or Restarting GDM Service... \e[0m"

#Reboot Server or Restart GDM Service ...
call_gui_rboot
}

gdm_update()
{
#common code to run 
gdm_common
echo
/bin/echo -e "\e[1;32m       |-| Modifying $gdmpath.css file...\e[0m"   
if [ -z "$selectcolor" ] 
then 
echo
	/bin/echo -e "\e[1;32m |-| Copying Picture to working Directory... \e[0m"
	cp "$pix" ${workdir}
	
#Updated Code
echo "
#lockDialogGroup {
background: #2c001e url('resource:///org/gnome/shell/theme/${fname}');
background-repeat: no-repeat;
background-size: cover;
background-position: center;
}" >> ${workdir}/$gdmpath.css  
sed -i "/<file>$gdmpath.css<\/file>/a<file>${fname}<\/file>" $xmlfile
else
echo "
#lockDialogGroup {
background-color: ${selectcolor}; }" >> ${workdir}/$gdmpath.css  
fi

}

#--------------------------------------------------------------------#
# Function 4  - Update css file on Ubuntu 24.04                      #
#--------------------------------------------------------------------#

user_login_change()
{ 

#Only valid for Ubuntu 24.04 so far 
echo "
.login-dialog-not-listed-button {
  color: #f2f2f2;
  background-color: transparent;
  padding: 0 6px;
  margin: 6px; }
  .login-dialog-not-listed-button:focus {
    color: #f2f2f2;
    box-shadow: inset 0 0 0 0px #ef8661 !important;
    background-color: rgba(0, 0, 0, 0.1875); }
    .login-dialog-not-listed-button:focus:hover {
      background-color: #3c3532; }
  .login-dialog-not-listed-button:hover {
    color: #f2f2f2;
    background-color: rgba(0, 0, 0, 0.1875);}
  .login-dialog-not-listed-button:active {
    color: #f2f2f2;
    background-color: rgba(0, 0, 0, 0.1875); }
    .login-dialog-not-listed-button:active:hover {
      background-color: rgba(0, 0, 0, 0.1875); }
    .login-dialog-not-listed-button:active:focus {
      background-color: rgba(0, 0, 0, 0.1875); }

.login-dialog-user-list-view {
  width: 25em;
  -st-vfade-offset: 3em; }
  .login-dialog-user-list-view .login-dialog-user-list {
    margin: 0 8px;
    spacing: 12px; }
    .login-dialog-user-list-view .login-dialog-user-list .login-dialog-user-list-item {
      color: #f2f2f2;
      background-color: transparent;
      border-radius: 6px;
      padding: 9px; }
      .login-dialog-user-list-view .login-dialog-user-list .login-dialog-user-list-item:selected, .login-dialog-user-list-view .login-dialog-user-list .login-dialog-user-list-item:focus {
        color: #f2f2f2;
        box-shadow: inset 0 0 0 0px #ef8661 !important;
        background-color: rgba(0, 0, 0, 0.1875); }
        .login-dialog-user-list-view .login-dialog-user-list .login-dialog-user-list-item:selected:hover, .login-dialog-user-list-view .login-dialog-user-list .login-dialog-user-list-item:focus:hover {
          background-color:rgba(0, 0, 0, 0.1875); }
      .login-dialog-user-list-view .login-dialog-user-list .login-dialog-user-list-item:hover {
        color: #f2f2f2;
        background-color: rgba(0, 0, 0, 0.1875); }
      .login-dialog-user-list-view .login-dialog-user-list .login-dialog-user-list-item:active {
        color: #f2f2f2;
        background-color: rgba(0, 0, 0, 0.1875); }
        .login-dialog-user-list-view .login-dialog-user-list .login-dialog-user-list-item:active:hover {
          background-color: rgba(0, 0, 0, 0.1875); }
        .login-dialog-user-list-view .login-dialog-user-list .login-dialog-user-list-item:active:focus {
          background-color: rgba(0, 0, 0, 0.1875); }
      .login-dialog-user-list-view .login-dialog-user-list .login-dialog-user-list-item .user-icon {
        border: 2px solid rgba(0, 0, 0, 0.1875); }
      .login-dialog-user-list-view .login-dialog-user-list .login-dialog-user-list-item .login-dialog-timed-login-indicator {
        height: 2px;
        margin-top: 6px;
        background-color: rgba(242, 242, 242, 0.7); }
      .login-dialog-user-list-view .login-dialog-user-list .login-dialog-user-list-item:logged-in .user-icon {
        border-color: transparent; }
        .login-dialog-user-list-view .login-dialog-user-list .login-dialog-user-list-item:logged-in .user-icon StIcon {
          background-color: rgba(211, 70, 21, 0.3); }" >> ${workdir}/$gdmpath.css  

}

#--------------------------------------------------------------------#
# Function 5  - Intermediate Function                                #
#--------------------------------------------------------------------#


#--------------------------------------------------------------------#
# Function 6  - Show Credits                                         #
#--------------------------------------------------------------------#

sh_credits() { 

/bin/echo -e "\e[1;36m  
  !-----------------------------------------------------!
  ! Change-Gdm-Background - Version : $ScriptVer               !
  ! Written By - Griffon - April. 2025                  !
  !                                                     !
  ! Web :www.c-nergy.be - www.c-nergy.be/blog           !
  !-----------------------------------------------------!
\e[0m"
echo
}

#--------------------------------------------------------------------------#
# -----------------------END Function Section             -----------------#
#--------------------------------------------------------------------------#

#--------------------------------------------------------------------------#
#------------                 MAIN SCRIPT SECTION       -------------------#  
#--------------------------------------------------------------------------#

#---------------------------------------------------#
#-- Step 0 - Try to Detect Ubuntu Version.... 
#---------------------------------------------------#

version=$(lsb_release -sd) 
codename=$(lsb_release -sc) 

#Trick to get prompted for sudo password - Nothing will be logged
sudo touch gdmlogin.log
#Call Check OS Function to validate OS Version 
check_os
#End of script - Show Credits
sh_credits
