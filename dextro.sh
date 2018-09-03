#!/bin/bash

YELLOW="\033[0;33m"
CYAN="\033[0;36m"
NC='\033[0m'

clear
echo -e "${YELLOW}Dextro Core Masternode Menu ${NC}"
echo -e "${CYAN}=============================================== ${NC}"
echo ""
PS3='Please enter your choice(enter to show menu) : '
options=("start" "stop" "getinfo" "edit config" "mnsync status" "masternode status" "Quit")
select opt in "${options[@]}"
do
    case $opt in
        "start")
         systemctl start Dextro
         echo -e "${YELLOW}starting node ${NC}";
         sleep 5
#dextrod -daemon -conf=/root/.dextro/dextro.conf -datadir=/root/.dextro
        echo "";
            ;;
        "stop")
         systemctl stop Dextro
         echo -e "${YELLOW}stopping node ${NC}";
         sleep 5
         #dextro-cli -conf=/root/.dextro/dextro.conf -datadir=/root/.dextro stop
        echo "";
            ;;
        "getinfo")
        dextro-cli -conf=/root/.dextro/dextro.conf -datadir=/root/.dextro getinfo
        echo "";
            ;;
         "edit config")
        nano /root/.dextro/dextro.conf
        echo "";
            ;;
         "mnsync status")
        echo -e "${YELLOW}mnsync status: ${NC}";
        dextro-cli -conf=/root/.dextro/dextro.conf -datadir=/root/.dextro mnsync status
        echo "";
        echo "";
            ;;
        "masternode status")
        echo -e "${YELLOW} masternode status : ${NC}";
        dextro-cli -conf=/root/.dextro/dextro.conf -datadir=/root/.dextro masternode status
    echo "";
    echo "";
            ;;
        "Quit")
            break
            ;;
        *) echo "invalid option $REPLY"
         clear
           ;;
    esac
done

