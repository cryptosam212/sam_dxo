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
    systemctl stop Dextro.service > /dev/null 2>&1
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
 rm -R dextro_ubuntu_16.04_v1.0.1.zip >/dev/null 2>&1
 wget https://github.com/dextrocoin/dextro/releases/download/2.0.0.0/dextro_v2.0_ubuntu_16.04.tar.gz >/dev/null 2>&1
  compile_error
  tar -xvzf dextro_v2.0_ubuntu_16.04.tar.gz >/dev/null 2>&1

 chmod +x $COIN_DAEMON $COIN_CLI >/dev/null 2>&1
  compile_error
  cp -r -p $COIN_DAEMON $COIN_CLI $COIN_PATH >/dev/null 2>&1
  cd  >/dev/null 2>&1
  rm -r dextrod >/dev/null 2>&1
  rm -r dextro-cli >/dev/null 2>&1
  rm -r dextro-tx >/dev/null 2>&1
  rm -r dextro-qt >/dev/null 2>&1
 rm -r dextro_v2.0_ubuntu_16.04.tar.gz* >/dev/null 2>&1

cd .dextro

sed -i "/\b\(addnode\)\b/d" dextro.conf

cat << EOF >> dextro.conf
addnode=185.57.104.158:39320 
addnode=8.12.17.58:39320 
addnode=5.189.171.202:39320 
addnode=92.242.3.82:39320 
addnode=209.250.236.40:39320 
addnode=199.247.13.142:39320 
addnode=45.77.155.11:39320 
addnode=80.211.99.13:39320 
addnode=98.24.33.121:39320 
addnode=185.180.231.10:39320 
addnode=139.99.97.156:39320 
addnode=212.237.56.132:39320 
addnode=209.250.226.6:39320 
addnode=80.240.29.16:39320
EOF


systemctl stop Dextro.service >/dev/null 2>&1
dextrod -daemon >/dev/null 2>&1

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

#update_config
