#/bin/bash
BLUE="\033[0;34m"
YELLOW="\033[0;33m"
NC="\033[0m"

cd ~
sed -i '/dxo/d' .bashrc
  echo "alias dxo_status=\"dextro-cli -datadir=/root/.dextro masternode status\"" >> .bashrc
  echo "alias dxo_stop=\"dextro-cli -datadir=/root/.dextro stop && systemctl stop Dextro\"" >> .bashrc
  echo "alias dxo_start=\"systemctl start Dextro\""  >> .bashrc
  echo "alias dxo_edit=\"nano /root/.dextro/dextro.conf\""  >> .bashrc
  echo "alias dxo_sync=\"dextro-cli -datadir=/root/.dextro mnsync status\"" >> .bashrc
  echo "alias dxo_getinfo=\"dextro-cli -datadir=/root/.dextro getinfo\"" >> .bashrc

echo -e "${BLUE}================================================================================================================================${NC}"
echo -e "DEXRO MENU INSTALLED"
echo -e ""
 echo -e "How to use: "
 echo -e "${YELLOW}dxo_start${NC} : command to start dextrod without ask confirmation"
 echo -e "${YELLOW}dxo_stop${NC} : command to stop dextrod without ask confirmation"
 echo -e "${YELLOW}dxo_edit${NC} : command to edit dextro.conf"
 echo -e "${YELLOW}dxo_sync${NC} : command to view sync status"
 echo -e "${YELLOW}dxo_getinfo${NC} : command to view getinfo"
 echo -e "${YELLOW}dxo_status${NC} : command to view masternode status"
 echo -e ""
 echo -e "${BLUE}================================================================================================================================${NC}"
 echo -e "${YELLOW}Thank you for your donation. "
 echo -e "Dextro: DFzaQis4RNHMuZjEkouzFzhHZjaHmZ4Qos "
 echo -e "DOGE: DBmgChHwG6GLXtQkhRUdGCpEvGwjMC2xdA  ${NC}"
 echo -e "${BLUE}================================================================================================================================${NC}"

exec bash
exit
