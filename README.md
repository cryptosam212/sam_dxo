# sam_dxo

Setup Masternode for Dextro Core

Dextro Core (DXO) Masternode guide

Requirements
Windows 7 or higher (as your Cold wallet)
Linux VPS (Ubuntu 16.04 64 bit) that running 24/7 such as Vultr (stable and cheap host), or other VPS provider (as your Hot wallet)
SSH client, to connect to Linux VPS. Recommend PuTTY
Part 1: Windows Cold Wallet Installation
NOTED:

Required to send 2,000 DXO into this wallet as MasterNode collateral, so we need about 2,005 DXO in our wallet
This wallet will be the one that receive the MasterNode rewards
It DOES NOT need to run 24/7
Install and run the dextro-qt wallet on your Windows machine
Download the latest wallet download wallet win 32 bit or download wallet win 64 bit
Extract wallet
Double click on dextro-qt to install wallet
Click "Yes" button if you get 'unknown publisher' warning to continue
If you first time run the wallet, a pop-up screen will prompt for Data Directory. By default, it will store in AppData\roaming\dextro directory.
Let the wallet sync until you see the tick symbol on the right bottom


Create a wallet address and send DXO coin to the address for your MasterNode collateral.
From the top menu, go to File -> Receiving addresses
Click on "New" button, enter a label (for example, MN1) and click on "OK" button

Select on the newly created wallet address from the list and then click on "Copy" button to copy the address into the clipboard
Send exactly 2,000 DXO coins to the address that you just copied. Ensure the address is correct before you send out the coin.
After coin is sent out, you can verify the balance in the 'Transactions' tab and wait for at least 10 confirmations to validate your transaction (it usually takes about 30 minutes).
Obtain MasterNode private key and transaction of the collateral transfer information.
From the top menu, go to Tools ->Debug console
Run the following command: masternode genkey 

A long private key will be displayed (example as per below) and required for both Windows wallet masternode config and Dextro Platform configuration later on: 
6K4Qop71Cs9sV5KoszVi9wCXXoXU2LHGdBNoeQrAose3TWEkTXc
Continue to run following command: masternode outputs

NOTE: In case your masternode outputs is BLANK, it could be you may not sent EXACTLY 2,000 DXO in a single transaction. So, you can send again exactly 2,000 DXO to address MN1

Now, we can setup masternode config. At windows wallet click 
Tools -> Open Masternode Configuration File. 
Fill masternode code at new line like this 

 

Part 2: Subscribe VPS for Hot Wallet server
NOTED:
We need IPv4
This server REQUIRED to run 24/7
Since running 24/7, strongly suggest not store any fund in this wallet to avoid losing fund in case server is attack.
You can subscribe VPS from provider like Vultr (stable and cheap host), or other similar providers with following requirements;

Register an account Vultr, then click on "+" button from the dashboard

Select any 'Server Location' follow by Ubuntu 16.04 x64 for 'Server Type' and $5/mo with 25 GB SSD for 'Server Size' (we also can use $2.5/mo with 20 GB SSD)
Don't choose IPv6 only

Leave 'Additional Features' optins uncheck
Enter a Hostname and Label for your VPS (for example, Dextro)

After successfully install the VPS, click on the server from the list to get and copy IP Address and root's Password

Part 3: Linux (Ubuntu) Hot Wallet Installation
NOTED:
You may use SSH client to connect the VPS. Recommend PuTTY
Launch PuTTY application and login into VPS. Copy VPS IP Address and click open.



Login as root. Copy VPS Password and paste it into PuTTY (mouse right click to paste. Password not shown and press Enter)


copy and paste this below code into putty

wget https://raw.githubusercontent.com/cryptosam212/sam_dxo/master/install_dextro.sh



bash install_dextro.sh


Wait and follow the installing


copy and paste your private key that generated

Press Enter to continue

If your setup is finish you will see screen like below image

Congratulations..... Your Dextro Masternode setup VPS was done
Part 4: Masternode Activation
Enable Masternode
Restart your Windows Cold Wallet. From the top menu, go to Tools -> Debug console
to acivate masternode, use command masternode start-alias MN_ALIAS

masternode start-alias MN1 


if successfull we shown like this


check at masternode tab and click update status for get newest status

if status enable, your masternode already activated. Check next 10minutes for active time must change forward. 
Check your MasterNode is enabled on VPS
Check Mnsync status for check sync completed. 

dextro-cli mnsync status 

and report must contain "IsBlockchainSynced" : true,


if already synced, check masternode status with :

dextro-cli masternode status


report contain "status" : "Masternode successfully started"
 

Congratulations, your masternode has been activated and running. Just wait for your first Dextro Masternode reward.







