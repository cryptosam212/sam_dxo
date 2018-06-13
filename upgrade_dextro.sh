#!/bin/bash

CONFIG_FILE='dextro.conf'
CONFIGFOLDER='/root/.dextro'
COIN_DAEMON='dextrod'
COIN_CLI='dextro-cli'
COIN_PATH='/usr/local/bin/'
COIN_NAME='Dextro'
COIN_PORT=39320
RPC_PORT=39321

NODEIP=$(curl -s4 icanhazip.com)

BLUE="\033[0;34m"
YELLOW="\033[0;33m"
CYAN="\033[0;36m" 
PURPLE="\033[0;35m"
RED='\033[0;31m'
GREEN="\033[0;32m"
NC='\033[0m'
MAG='\e[1;35m'

purgeOldInstallation() {
    echo -e "${GREEN}Searching and removing old $COIN_NAME files and configurations${NC}"
    #kill wallet daemosudo 
    systemctl stop Dextro.service
    sudo killall -9 dextrod > /dev/null 2>&1
sudo killall dextrod > /dev/null 2>&1    
#remove old ufw port allow
    #sudo ufw delete allow 39320/tcp > /dev/null 2>&1
    #remove binaries and Dextro utilities
    cd /usr/local/bin && sudo rm dextro-cli dextro-tx dextrod > /dev/null 2>&1 && cd
    echo -e "${GREEN}* Done${NONE}";
}


function download_node() {
  echo -e "${GREEN}Upgrade and Installing VPS $COIN_NAME Daemon${NC}"
 cd >/dev/null 2>&1
 wget https://github.com/JDXOCoin20180520Z/dxo_v1.0.1/raw/master/dextro_ubuntu_16.04_v1.0.1.zip >/dev/null 2>&1
  compile_error
  unzip dextro_ubuntu_16.04_v1.0.1.zip >/dev/null 2>&1
 cd dextro >/dev/null 2>&1  
 chmod +x $COIN_DAEMON $COIN_CLI >/dev/null 2>&1
  compile_error
  cp -r -p $COIN_DAEMON $COIN_CLI $COIN_PATH >/dev/null 2>&1
  cd - >/dev/null 2>&1
  rm -r dextro >/dev/null 2>&1
  dextrod -daemon  >/dev/null 2>&1
  clear
important_information
}



function compile_error() {
if [ "$?" -gt "0" ];
 then
  echo -e "${RED}Failed to compile $COIN_NAME. Please investigate.${NC}"
  exit 1
fi
}




function important_information() {
 echo
 echo -e "${BLUE}============================================================================================================================${NC}"
 echo -e "${PURPLE}UPGRADE COMPLETED ${NC}"
 echo -e "${BLUE}=============================================================================================================================${NC}"
}


##### Main #####
clear

purgeOldInstallation
download_node

