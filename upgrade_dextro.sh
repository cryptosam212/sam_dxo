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
  systemctl stop dextro.service > /dev/null 2>&1
dextro-cli stop > /dev/null 2>&1
sudo killall -9 dextrod > /dev/null 2>&1
sleep 5
PROCESSCOUNT=$(ps -ef |grep -v grep |grep -cw $COIN_DAEMON )

if [ $PROCESSCOUNT -eq 0 ]
then
echo "ok"
else
echo "kill $COIN_DAEMON"
dextro-cli stop > /dev/null 2>&1
killall -9 $COIN_DAEMON > /dev/null 2>&1
fi

    cd /usr/local/bin && sudo rm dextro-cli dextro-tx dextrod > /dev/null 2>&1 && cd
    echo -e "${GREEN}* Done${NONE}";
}
function download_node() {
  echo -e "${GREEN}Upgrade and Installing VPS $COIN_NAME Daemon${NC}"
cd /root/ >/dev/null 2>&1
rm -r dextrocore.zip*  >/dev/null 2>&1
 rm -r dextro-v2.0.2.1-ubuntu_16* >/dev/null 2>&1
echo -e "${NC}download new wallet"

 wget -c https://github.com/dextrocoin/dextro/releases/download/2.0.2.2/dextro_v2.0.2.2_ubuntu_16.tar.gz >/dev/null 2>&1
  compile_error
  tar -xvzf dextro_v2.0.2.2_ubuntu_16.tar.gz >/dev/null 2>&1

 chmod +x $COIN_DAEMON $COIN_CLI >/dev/null 2>&1
echo -e "copy new wallet to usr/local/bin"
  cp -r -p $COIN_DAEMON $COIN_CLI $COIN_PATH >/dev/null 2>&1
  cd  >/dev/null 2>&1
  rm -r dextrod >/dev/null 2>&1
  rm -r dextro-cli >/dev/null 2>&1
  rm -r dextro-tx >/dev/null 2>&1
  rm -r dextro-qt >/dev/null 2>&1
 rm -r dextro_v2.0.2.2_ubuntu_16.tar* >/dev/null 2>&1
cd .dextro
echo "addnode"
sed -i "/\b\(addnode\)\b/d" dextro.conf

cat << EOF >> dextro.conf
addnode=207.180.213.15:39320
addnode=207.180.213.19:39320
addnode=5.189.139.75:39320
addnode=207.180.199.86:39320 
addnode=207.180.212.96:39320 
addnode=207.180.212.101:39320
addnode=173.212.206.227:39320
addnode=207.180.217.56:39320
addnode=207.180.217.57:39320
addnode=207.180.217.58:39320
addnode=207.180.217.59:39320
addnode=177.152.49.150
addnode=177.152.49.151
addnode=177.152.49.152
addnode=177.152.49.153
addnode=177.152.49.154

EOF

echo -e "delete folder blocks and chainstate. Please do not stop this process"
rm -r blocks >/dev/null 2>&1
rm -r chainstate >/dev/null 2>&1
rm -r backups >/dev/null 2>&1
rm -r -f .lock
rm budget.dat
rm db.log
rm debug.log
rm fee_estimates.dat
rm mncache.dat
rm mnpayments.dat
#rm peers.dat
#wget https://github.com/cryptosam212/sam_dxo/raw/master/peers.dat >/dev/null 2>&1

#cd >/dev/null 2>&1

#wget --load-cookies /tmp/cookies.txt "https://docs.google.com/uc?export=download&confirm=$(wget --quiet --save-cookies /tmp/cookies.txt --keep-session-cookies --no-check-certificate 'https://docs.google.com/uc?export=download&id=1scXN9ksZ7xJnlLYhDlNSLSH8pPvM_7zG' -O- | sed -rn 's/.*confirm=([0-9A-Za-z_]+).*/\1\n/p')&id=1scXN9ksZ7xJnlLYhDlNSLSH8pPvM_7zG" -O dextro_blockchain201086.zip && rm -rf /tmp/cookies.txt >/dev/null 2>&1
wget -c https://github.com/dextrocoin/dextro/releases/download/2.0.2.2/dextro_v2.0.2.2_blocks_302741.zip >/dev/null 2>&1
echo -e "${YELLOW} update blocks ${NC}";
unzip dextro_v2.0.2.2_blocks_302741.zip  >/dev/null 2>&1
#cd dextro_blockchain201086 >/dev/null 2>&1
#cp -r -p blocks $CONFIGFOLDER >/dev/null 2>&1
#cp -r -p chainstate $CONFIGFOLDER >/dev/null 2>&1
#cd >/dev/null 2>&1
rm -r dextro_v2.0.2.2_blocks_302741* >/dev/null 2>&1

cd >/dev/null 2>&1

echo -e "run daemon"
sytemctl enable Dextro >/dev/null 2>&1
systemctl start Dextro >/dev/null 2>&1

sleep 5
PROCESSCOUNT=$(ps -ef |grep -v grep |grep -cw $COIN_DAEMON )
if [ $PROCESSCOUNT -eq 0 ]
then
echo "start $COIN_DAEMON"
$COIN_DAEMON -daemon
fi

 echo -e "${BLUE}============================================================================================================================${NC}"
 echo -e "${YELLOW}UPGRADE COMPLETED ${NC}"
 echo -e ""
 echo -e "${YELLOW}Thank you for your donation. "
 echo -e "Dextro: DFzaQis4RNHMuZjEkouzFzhHZjaHmZ4Qos "
 echo -e "DOGE: DBmgChHwG6GLXtQkhRUdGCpEvGwjMC2xdA  ${NC}"
 echo -e "${BLUE}=============================================================================================================================${NC}"

}
function compile_error() {
if [ "$?" -gt "0" ];
 then
  echo -e "${RED}Failed to compile $COIN_NAME. Please investigate.${NC}"
  exit 1
fi
}



##### Main #####
clear

purgeOldInstallation
download_node
