#!/bin/bash

#################################################################################
# Script Name   :- backup_restore.sh                                            #
# Description   :- Fast install of services                                     #
# Created By    :- thexhosting.com                                              #
# Version       :- 0                                                            #
# Comments      :-                                                              #                                                            #                                                                               #                                         
#################################################################################        

#----------------------------------
# Colors codes for console output
#----------------------------------
GREEN="\033[1;32m";
RED='\033[0;31m'

BoldWhite='\033[1;37m'
BoldCyan='\033[1;36m'
NoColor='\033[0m'

# ==========================================
# Global variables used in the script
# ==========================================

version = "0"

# Get the client's local IP address
client_ip=$(hostname -I | cut -d ' ' -f1)

# ==========================================
#  Just a simple start 
# ==========================================

banner(){
    clear;
    echo -e "${GREEN}                                                                              ${NoColor}";
    echo -e "${GREEN}█████ █████ █████ █████ █████ █████ █████ █████ █████ █████ █████ █████ █████ ${NoColor}";
    echo -e "${GREEN}                                                                              ${NoColor}";
    echo -e "${GREEN}                             ██  ██████   █████                               ${NoColor}";
    echo -e "${GREEN}                             ██ ██       ██   ██                              ${NoColor}";
    echo -e "${GREEN}                             ██ ██   ███ ███████                              ${NoColor}";
    echo -e "${GREEN}                        ██   ██ ██    ██ ██   ██                              ${NoColor}";
    echo -e "${GREEN}                         █████   ██████  ██   ██                              ${NoColor}";
    echo -e "${GREEN}                                                                              ${NoColor}";
    echo -e "${GREEN}                     EASY PTERODACTYL INSTALLER SCRIPT                        ${NoColor}";
    echo -e "${BoldCyan}==============================================================================${NoColor}"
    echo -e "${BoldCyan} IP: $client_ip || VERSION: $version                                           ${NoColor}";
    echo -e "${BoldCyan} STORAGE DIRECTORY: $storage_directory || CREATED BY THEXHOSTING.COM           ${NoColor}";
    echo -e "${BoldCyan}==============================================================================${NoColor}";
}

# ==========================================
#  Check for curl
# ==========================================

if ! [ -x "$(command -v curl)" ]; then
  echo "* curl is required in order for this script to work."
  echo "* install using: apt install curl"
  exit 1
fi

# dectect for errors 

# ==========================================
#  PTERODACTYL INSTALLER SCRIPT - MAIN MENU
# ==========================================

echo -e "─────────────────────────────────────────────────────────"
echo -e "${BoldWhite}                  WHAT WOULD YOU LIKE TO DO?                   ${NoColor}"
echo -e "─────────────────────────────────────────────────────────"
echo -e ""
echo -e ""
echo -e "    ${RED}1.${NoColor} Install Pterodactyl Panel"
echo -e "    ${RED}2.${NoColor} Install Pterodactyl Wings"
echo -e "    ${RED}3.${NoColor} Create Public MYSQL USER"
echo -e "    ${RED}4.${NoColor} Install PHPMYADMIN Panel"
echo -e "    ${RED}5.${NoColor} Install STATUS Panel (KUMA)"
echo -e "    ${RED}6.${NoColor} Exit"
echo -e ""
read -p "Select an option (1-4): " menu_option