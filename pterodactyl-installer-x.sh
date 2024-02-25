#!/bin/bash

#################################################################################
# Script Name   :- backup_restore.sh                                            #
# Description   :- Fast install of services                                     #
# Created By    :- thexhosting.com                                              #
# Version       :- 0                                                            #
# Comments      :-                                                              #                                                            #                                                                               #                                         
#################################################################################        

# ==========================================
#  Just a simple start 
# ==========================================

banner(){
  clear
    echo ""
    echo -e "   
                    
                     Y8888b,
                   ,oA8888888b,
             ,aaad8888888888888888bo,
          ,d888888888888888888888888888b,
        ,888888888888888888888888888888888b,
       d8888888888888888888888888888888888888,
      d888888888888888888888888888888888888888b
     d888888P                      Y888888888888,
     88888P                     Ybaaaa8888888888l
    a8888                        Y8888P   V888888
  d8888888a                                 Y8888
 AY/    \Y8b                                   Y8b
 Y        YP                                    
 
 "
    echo ""
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