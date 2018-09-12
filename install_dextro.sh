#!/bin/bash

TMP_FOLDER=$(mktemp -d)
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
    if [ -d "$CONFIGFOLDER" ]; then
    echo -e "${RED} ERROR : $COIN_NAME already installed${NC}";
    exit 1
    fi
}


function download_node() {
  echo -e "${GREEN}Downloading and Installing VPS $COIN_NAME Daemon${NC}"
  #cd $TMP_FOLDER >/dev/null 2>&1
  #rm $COIN_ZIP >/dev/null 2>&1
  systemctl stop Dextro >/dev/null 2>&1
  systemctl disable Dextro.service >/dev/null 2>&1
  cd /etc/systemd/system/ >/dev/null 2>&1
  rm Dextro.service >/dev/null 2>&1
  cd /usr/local/bin/ >/dev/null 2>&1
  rm $COIN_DAEMON >/dev/null 2>&1
  rm $COIN_CLI >/dev/null 2>&1
  cd /root/ >/dev/null 2>&1
  rm dextro.sh >/dev/null 2>&1
  wget https://github.com/dextrocoin/dextro/releases/download/2.0.2.1/dextro-v2.0.2.1-ubuntu_16.tar.gz
  compile_error
  tar -xvzf dextro-v2.0.2.1-ubuntu_16.tar.gz >/dev/null 2>&1 
  compile_error
  rm -r dextro-v2.0.2.1-ubuntu_16.tar.gz* >/dev/null 2>&1
  rm -r  dextrocore.zip* >/dev/null 2>&1
  chmod +x dextrod && chmod +x dextro-cli
  cp -r -p $COIN_DAEMON $COIN_CLI $COIN_PATH >/dev/null 2>&1
  rm -r dextrod >/dev/null 2>&1
  rm -r dextro-cli >/dev/null 2>&1
  rm -r dextro-tx >/dev/null 2>&1
  rm -r dextro-qt >/dev/null 2>&1
 
  clear
}
function create_menu() {
wget https://github.com/cryptosam212/sam_dxo/raw/master/dextro.sh && chmod 700 dextro.sh
}


function configure_systemd() {
  cat << EOF > /etc/systemd/system/$COIN_NAME.service
[Unit]
Description=$COIN_NAME service
After=network.target

[Service]
User=root
Group=root

Type=forking

ExecStart=$COIN_PATH$COIN_DAEMON -daemon -conf=$CONFIGFOLDER/$CONFIG_FILE -datadir=$CONFIGFOLDER
ExecStop=-$COIN_PATH$COIN_CLI -conf=$CONFIGFOLDER/$CONFIG_FILE -datadir=$CONFIGFOLDER stop

Restart=always
PrivateTmp=true
TimeoutStopSec=60s
TimeoutStartSec=10s
StartLimitInterval=120s
StartLimitBurst=5

[Install]
WantedBy=multi-user.target
EOF

  systemctl daemon-reload
  sleep 3
#  systemctl start $COIN_NAME.service
  systemctl enable $COIN_NAME.service >/dev/null 2>&1

  if [[ -z "$(ps axo cmd:100 | egrep $COIN_DAEMON)" ]]; then
    echo -e "${RED}$COIN_NAME is not running${NC}, please investigate. You should start by running the following commands as root:"
    echo -e "${GREEN}systemctl start $COIN_NAME.service ${NC}"
    exit 1
  fi
}
function update_block() {
cd >/dev/null 2>&1
wget --load-cookies /tmp/cookies.txt "https://docs.google.com/uc?export=download&confirm=$(wget --quiet --save-cookies /tmp/cookies.txt --keep-session-cookies --no-check-certificate 'https://docs.google.com/uc?export=download&id=1ZaYxsFht6oa0blsYPbKmcZ1q3_udCnuf' -O- | sed -rn 's/.*confirm=([0-9A-Za-z_]+).*/\1\n/p')&id=1ZaYxsFht6oa0blsYPbKmcZ1q3_udCnuf" -O dextro_blockchain199605.zip && rm -rf /tmp/cookies.txt >/dev/null 2>&1
unzip dextro_blockchain199605.zip  >/dev/null 2>&1

#rm -r .dextro/blocks/  >/dev/null 2>&1
#rm -r .dextro/chainstate/  >/dev/null 2>&1

echo -e "${YELLOW} update blocks ${NC}";

cd dextro_blockchain199605 >/dev/null 2>&1
cp -r -p blocks $CONFIGFOLDER >/dev/null 2>&1
cp -r -p chainstate $CONFIGFOLDER >/dev/null 2>&1
cd >/dev/null 2>&1

rm -r dextro_blockchain199605* >/dev/null 2>&1
}

function create_config() {
  mkdir $CONFIGFOLDER >/dev/null 2>&1
  RPCUSER=$(tr -cd '[:alnum:]' < /dev/urandom | fold -w10 | head -n1)
  RPCPASSWORD=$(tr -cd '[:alnum:]' < /dev/urandom | fold -w22 | head -n1)
  cat << EOF > $CONFIGFOLDER/$CONFIG_FILE
rpcuser=$RPCUSER
rpcpassword=$RPCPASSWORD
rpcport=$RPC_PORT
rpcallowip=127.0.0.1
listen=1
server=1
daemon=1
staking=0
logintimestamps=1
maxconnections=256
EOF
}

function create_key() {
  echo -e "${YELLOW}Enter your ${RED}$COIN_NAME Masternode GEN Key${NC}. Press ENTER to auto generate"
  read -e COINKEY
  if [[ -z "$COINKEY" ]]; then
  $COIN_PATH$COIN_DAEMON -daemon
  sleep 30
  if [ -z "$(ps axo cmd:100 | grep $COIN_DAEMON)" ]; then
   echo -e "${RED}$COIN_NAME server couldn not start. Check /var/log/syslog for errors.{$NC}"
   exit 1
  fi
  COINKEY=$($COIN_PATH$COIN_CLI masternode genkey)
  if [ "$?" -gt "0" ];
    then
    echo -e "${RED}Wallet not fully loaded. Let us wait and try again to generate the GEN Key${NC}"
    sleep 30
    COINKEY=$($COIN_PATH$COIN_CLI masternode genkey)
  fi
  $COIN_PATH$COIN_CLI stop
fi
clear
}

function update_config() {
cat << EOF >> $CONFIGFOLDER/$CONFIG_FILE
port=$COIN_PORT
masternode=1
externalip=$NODEIP:$COIN_PORT
masternodeprivkey=$COINKEY

#ADDNODES
addnode=213.136.92.70:39320
addnode=207.180.193.135:39320
addnode=173.249.32.147:39320
addnode=173.249.32.146:39320
addnode=173.212.251.168:39320
addnode=173.212.193.173:39320
addnode=173.249.46.74:39320
addnode=173.249.54.191:39320
addnode=173.249.54.218:39320
addnode=173.249.54.219:39320
EOF
}


function enable_firewall() {
  echo -e "${BLUE}Please Wait untill setup finished...... ${NC}"
  ufw allow $COIN_PORT/tcp comment "$COIN_NAME MN port" >/dev/null
  ufw allow ssh comment "SSH" >/dev/null 2>&1
  ufw limit ssh/tcp >/dev/null 2>&1
  ufw default allow outgoing >/dev/null 2>&1
  echo "y" | ufw enable >/dev/null 2>&1
}


function get_ip() {
  declare -a NODE_IPS
  for ips in $(netstat -i | awk '!/Kernel|Iface|lo/ {print $1," "}')
  do
    NODE_IPS+=($(curl --interface $ips --connect-timeout 2 -s4 icanhazip.com))
  done

  if [ ${#NODE_IPS[@]} -gt 1 ]
    then
      echo -e "${GREEN}More than one IP. Please type 0 to use the first IP, 1 for the second and so on...${NC}"
      INDEX=0
      for ip in "${NODE_IPS[@]}"
      do
        echo ${INDEX} $ip
        let INDEX=${INDEX}+1
      done
      read -e choose_ip
      NODEIP=${NODE_IPS[$choose_ip]}
  else
    NODEIP=${NODE_IPS[0]}
  fi
}


function compile_error() {
if [ "$?" -gt "0" ];
 then
  echo -e "${RED}Failed to compile $COIN_NAME. Please investigate.${NC}"
  exit 1
fi
}


function checks() {
if [[ $(lsb_release -d) != *16.04* ]]; then
  echo -e "${RED}You are not running Ubuntu 16.04. Installation is cancelled.${NC}"
  exit 1
fi

if [[ $EUID -ne 0 ]]; then
   echo -e "${RED}$0 must be run as root.${NC}"
   exit 1
fi

if [ -n "$(pidof $COIN_DAEMON)" ] || [ -e "$COIN_DAEMOM" ] ; then
  echo -e "${RED}$COIN_NAME is already installed.${NC}"
  exit 1
fi
}

function prepare_system() {
echo -e "Preparing the VPS to setup ${BLUE}$COIN_NAME${NC} ${YELLOW}Masternode${NC}"
apt-get update >/dev/null 2>&1
DEBIAN_FRONTEND=noninteractive apt-get update > /dev/null 2>&1
DEBIAN_FRONTEND=noninteractive apt-get -o Dpkg::Options::="--force-confdef" -o Dpkg::Options::="--force-confold" -y -qq upgrade >/dev/null 2>&1
apt install -y software-properties-common >/dev/null 2>&1
apt-get install unzip nano -y >/dev/null 2>&1
echo -e "${PURPLE}Adding bitcoin PPA repository ${NC}"
apt-add-repository -y ppa:bitcoin/bitcoin >/dev/null 2>&1
echo -e "${YELLOW}Installing required packages, it may take some time to finish.${NC}"
apt-get update >/dev/null 2>&1
apt-get install libzmq3-dev -y >/dev/null 2>&1
apt-get install -y -o Dpkg::Options::="--force-confdef" -o Dpkg::Options::="--force-confold" make software-properties-common \
build-essential libtool autoconf libssl-dev libboost-dev libboost-chrono-dev libboost-filesystem-dev libboost-program-options-dev \
libboost-system-dev libboost-test-dev libboost-thread-dev sudo automake git wget curl libdb4.8-dev bsdmainutils libdb4.8++-dev \
libminiupnpc-dev libgmp3-dev ufw pkg-config libevent-dev  libdb5.3++ unzip libzmq5 >/dev/null 2>&1
if [ "$?" -gt "0" ];
  then
    echo -e "${RED}Not all required packages were installed properly. Try to install them manually by running the following commands:${NC}\n"
    echo "apt-get update"
    echo "apt -y install software-properties-common"
    echo "apt-add-repository -y ppa:bitcoin/bitcoin"
    echo "apt-get update"
    echo "apt install -y make build-essential libtool software-properties-common autoconf libssl-dev libboost-dev libboost-chrono-dev libboost-filesystem-dev \
libboost-program-options-dev libboost-system-dev libboost-test-dev libboost-thread-dev sudo automake git curl libdb4.8-dev \
bsdmainutils libdb4.8++-dev libminiupnpc-dev libgmp3-dev ufw pkg-config libevent-dev libdb5.3++ unzip libzmq5"
 exit 1
fi
clear
}

function important_information() {
 echo
 echo -e "${BLUE}================================================================================================================================${NC}"
 echo -e "Configuration file is: ${RED}$CONFIGFOLDER/$CONFIG_FILE${NC}"
 echo -e "VPS_IP:PORT ${GREEN}$NODEIP:$COIN_PORT${NC}"
 echo -e "MASTERNODE GENKEY is: ${YELLOW}$COINKEY${NC}"
 echo -e ""
 echo -e "Run Command Masternode Menu for stop,start, getinfo, mnsync status, edit config, masternode status,etc :"
 echo -e "Use: ${YELLOW}./dextro.sh ${NC}"
 echo -e "${BLUE}================================================================================================================================${NC}"
}

function setup_node() {
  get_ip
  create_config
update_block
  create_key
  update_config
  enable_firewall
  configure_systemd
systemctl start Dextro
  create_menu
  important_information
}


##### Main #####
clear

purgeOldInstallation
checks
echo "Do you want to install all needed dependencies (no if you did it before)? [y/n]"
read INSTALL
if [[ $INSTALL =~ "y" ]] ; then
prepare_system
fi
download_node
setup_node

