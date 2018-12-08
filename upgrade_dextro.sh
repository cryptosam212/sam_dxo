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
{
echo "kill $COIN_DAEMON"
dextro-cli stop > /dev/null 2>&1
killall -9 $COIN_DAEMON > /dev/null 2>&1
}
fi
sleep 5

PROCESSCOUNT=$(ps -ef |grep -v grep |grep -cw $COIN_DAEMON )

if [ $PROCESSCOUNT -eq 0 ]
then
echo "ok"
else
{
echo "kill again $COIN_DAEMON"
dextro-cli stop > /dev/null 2>&1
killall -9 $COIN_DAEMON > /dev/null 2>&1
}
fi


    cd /usr/local/bin && sudo rm dextro-cli dextro-tx dextrod > /dev/null 2>&1 && cd
    echo -e "${GREEN}* Done${NONE}";
}
function download_node() {
  echo -e "${GREEN}Upgrade and Installing VPS $COIN_NAME Daemon${NC}"
cd /root/ >/dev/null 2>&1
echo -e "${NC}download new wallet"

 wget -c https://github.com/dextrocoin/dextro/releases/download/2.0.2.3/dextro_v2.0.2.3_ubuntu_16.tar.gz >/dev/null 2>&1
  compile_error
  tar -xvzf dextro_v2.0.2.3_ubuntu_16.tar.gz >/dev/null 2>&1

 chmod +x $COIN_DAEMON $COIN_CLI >/dev/null 2>&1
echo -e "copy new wallet to usr/local/bin"
  cp -r -p $COIN_DAEMON $COIN_CLI $COIN_PATH >/dev/null 2>&1
  cd  >/dev/null 2>&1
  rm -r dextrod >/dev/null 2>&1
  rm -r dextro-cli >/dev/null 2>&1
  rm -r dextro-tx >/dev/null 2>&1
  rm -r dextro-qt >/dev/null 2>&1
 rm -r dextro_v2.0.2.3_ubuntu_16.tar.gz* >/dev/null 2>&1

cd $CONFIGFOLDER
echo "addnode"
sed -i "/\b\(addnode\)\b/d" dextro.conf

cat << EOF >> dextro.conf
addnode=[2a02:c207:2020:8506::5]:39320
addnode=136.243.185.12:39320
addnode=5.135.208.61:39320
addnode=81.2.246.189:39320
addnode=51.68.131.108:39320
addnode=51.68.209.141:39320
addnode=45.32.235.32:39320
addnode=217.61.110.42:39320
addnode=207.148.20.99:39320
addnode=[2607:fcd0:105:5f04:0:4910:f9ba:1]:39320
addnode=149.28.172.4:39320
addnode=95.179.168.44:39320
addnode=88.191.20.14:39320
addnode=162.212.156.102:39320
addnode=[2001:19f0:5001:2be9:5400:1ff:fe9f:b528]:39320
addnode=80.211.88.106:39320
addnode=195.181.223.173:39320
addnode=80.211.203.130:39320
addnode=194.182.66.86:39320
addnode=185.28.103.95:39320
addnode=118.24.116.93:39320
addnode=80.211.234.252:39320
addnode=94.177.204.85:39320

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
wget -c https://github.com/dextrocoin/dextro/releases/download/2.0.2.3/dextro_blocks.zip >/dev/null 2>&1
echo -e "${YELLOW} update blocks ${NC}";
unzip dextro_blocks.zip  >/dev/null 2>&1
cd dextro_blocks_322715 >/dev/null 2>&1
cp -r -p blocks $CONFIGFOLDER >/dev/null 2>&1
cp -r -p chainstate $CONFIGFOLDER >/dev/null 2>&1
cd >/dev/null 2>&1
rm -r dextro_blocks_322715* >/dev/null 2>&1

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
