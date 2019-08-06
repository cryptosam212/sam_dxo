# Dextro Masternode guide

<h2>Requirements</h2>
				<ul>
				  <li>Windows 7 or higher (as your Cold wallet)</li>
				  <li>Linux VPS (Ubuntu 16.04 64 bit) that running 24/7 such as <a href="https://www.vultr.com/?ref=7426137" rel="nofollow" target="top">Vultr (stable and cheap host)</a>, or other VPS provider (as your Hot wallet)</li>
				  <li>SSH client, to connect to Linux VPS. Recommend <a href="https://putty.org" rel="nofollow" target="_blank">PuTTY</a></li>
				</ul>
				<h2 style="color: #25499A">Part 1: Windows Cold Wallet Installation</h2>
				<p>NOTED:</p>
				<ul>
				  <li>Required to send 10,000 DXO into this wallet as MasterNode collateral, so we need about 10,005 DXO in our wallet</li>
				  <li>This wallet will be the one that receive the MasterNode rewards</li>
				  <li>It DOES NOT need to run 24/7</li>
				</ul>
				<h3><ol>
				  <li>
					Install and run the dextro-qt wallet  on your Windows machine
				  </li>
				</ol></h3>
				<ol>
				  <ol type="a">
					<li>Download DEXTRO the latest wallet at <a href="https://github.com/dextrocoin/dextro/releases/download/3.0.0.0" target="_blank">https://github.com/dextrocoin/dextro/releases/download/3.0.0.0/</a><br>
					</li>
					<li>Extract wallet </li>
					<li>Double  click on <strong>dextro-qt</strong> to install wallet</li>
					<li>Click  &quot;Yes&quot; button if you get 'unknown publisher' warning to continue</li>
					<li>If  you first time run the wallet, a pop-up screen will prompt for Data Directory.  By default, it will store in AppData\roaming\dextro directory.</li>
					<li>Let  the wallet sync until you see the tick symbol on the right bottom</li>
					<p><img src="http://dextro.io/images/wallet1.png" width="1000px" style="margin:10px"></p>
	</ol>
	</ol>
					<h3><ol start="2">
				  <li>
				   Create a wallet address and send DXO coin to the address for your MasterNode collateral.
				  </li>
				</ol></h3>
				<ol>
				  <ol type="a">
					<li>From  the top menu, go to <strong>File</strong> -&gt;  Receiving addresses</li>
					<li>Click  on &quot;<strong>New</strong>&quot; button, enter a  label (for example, MN1) and click on &quot;OK&quot; button<br>
					<img src="http://dextro.io/images/wallet2.jpg" width="1000px" style="margin:10px">
					</li>
					<li>Select on the newly created wallet address from the list and then click on "Copy" button to copy the address into the clipboard</li>
					<li>Send exactly 10,000 DXO coins to the address that you just copied. Ensure the address is correct before you send out the coin.</li>
					<li>After coin is sent out, you can verify the balance in the 'Transactions' tab and wait for at least 10 confirmations to validate your transaction (it usually takes about 30 minutes).</li>
				  </ol>
				</ol>

<h3><ol start="3">
	  <li>Obtain MasterNode private key and transaction of the collateral transfer information.
 </li>
</ol></h3>
<ol>
  <ol type="a">
					<li>From the top menu, go to Tools -&gt;Debug console</li>
					<li style=" margin-bottom:20px">
					Run the following command: <span style="background-color: #86BBE1; padding:3px 5px 3px 5px"><strong>masternode genkey</strong></span>
					<br>
				<img src="https://raw.githubusercontent.com/cryptosam212/sam_dxo/master/wallet3.jpg" width="1000px" style="margin:10px"><br>
					A long  private key will be displayed (example as per below) and required for both Windows  wallet masternode config and Dextro Platform configuration later on:
					<br>
				<span style="font-size:20px; background-color:#86BBE1; padding:3px 5px 3px 5px; margin-left:10px"><strong>6K4Qop71Cs9sV5KoszVi9wCXXoXU2LHGdBNoeQrAose3TWEkTXc</strong></span>
					</li>
					<li>Continue to run following command:   <span style="font-size:16px; background-color:#86BBE1; padding:3px 5px 3px 5px; font-weight:bold">masternode outputs</span><br>
				<img src="http://dextro.io/images/wallet4.jpg" width="1000px" style="margin:10px">
				<br>
					  <p><strong>NOTE:</strong> In case your masternode outputs is  BLANK, it could be you may not sent EXACTLY 2,000 DXO in a single transaction. So, you can send again exactly 2,000 DXO to address MN1</p>
					</li>
					<li>
					Now, we can setup masternode config. At windows wallet click 
					  <br>
					  Tools -&gt; Open Masternode Configuration File.
					  <br>
					Fill masternode code at new line like this <br>
				<img src="http://dextro.io/images/masternode_config.jpg" width="1000px" style="margin:10px"></li>
				  </ol>
				</ol>
				<p>&nbsp;</p>
				<h2 style="color: #25499A">Part 2: Subscribe VPS for Hot Wallet server</h2>
				<p>NOTED:<br>
				</p>
				<ul>
				  <li>We need <strong style="color:#FF0000">IPv4</strong></li>
				  <li>This server REQUIRED to run 24/7</li>
				  <li>Since running 24/7, strongly suggest not store any fund in this wallet to avoid losing fund in case server is attack.</li>
				</ul>
				<ol style="font-weight:bold">
				<p>You can subscribe VPS from provider like <a href="https://www.vultr.com/?ref=7426137" rel="nofollow" target="_blank">Vultr (stable and cheap host)</a>, or other similar providers with following requirements;</p>


<ol type="a">
	<li>
<br/>Promo Vultr, get Discount<br/>
<a href="https://www.vultr.com/?ref=7773816-4F"><img src="https://www.vultr.com/media/banner_2.png" width="468" height="60"></a>
	</li>
					<li>Register an account Vultr, then click on &quot;+&quot; button from the dashboard<br>
					<img src="https://raw.githubusercontent.com/cryptosam212/sam_dxo/master/vultr1.png" width="800px" style="margin:10px">
						
</li>
					<li>Select any 'Server Location' follow by Ubuntu 16.04 x64 for 'Server Type' and $5/mo with 25 GB SSD for 'Server Size' <br>
				<img src="https://raw.githubusercontent.com/cryptosam212/sam_dxo/master/vultr2.png" width="800px" style="margin:10px">
				</li>
					<li>Enter a Hostname and Label for your VPS (for example, Dextro)<br>
				<img src="https://raw.githubusercontent.com/cryptosam212/sam_dxo/master/vultr3.png" width="800px" style="margin:10px">
				</li>
					<li>After successfully install the VPS, click on the server from the list to get and copy <strong>IP Address</strong> and <strong>root's Password</strong><br>
				<img src="https://raw.githubusercontent.com/cryptosam212/sam_dxo/master/vultr4.png" width="800px" style="margin:10px"></li>
				  </ol>
				  </ol>
				<h2 style="color: #25499A">Part 3: Linux (Ubuntu) Hot Wallet Installation</h2>
				<p>NOTED:<br>
				</p>
				<ul>
				  <li>You may use SSH client to connect the VPS. Recommend <a href="https://putty.org" rel="nofollow" target="_blank">PuTTY</a></li>
				</ul>

<h3><ol>
				  <li>
					Launch PuTTY application and login into VPS. Copy VPS IP Address and click open.<br>
				<img src="https://raw.githubusercontent.com/cryptosam212/sam_dxo/master/putty1.png" width="500px" style="margin:10px">
				<br>
				<img src="https://raw.githubusercontent.com/cryptosam212/sam_dxo/master/putty1a.png" width="500px" style="margin:10px"><br>
				<br>
				Login as root. Copy VPS Password and paste it into PuTTY (mouse right click to paste. Password not shown and press Enter)<br>
				<img src="https://raw.githubusercontent.com/cryptosam212/sam_dxo/master/putty2.png" width="600px" style="margin:10px"><br>
				<br>

</li>
				  <li>
				  copy and paste this below code into putty<br>
				  <br>
				<ol type="a">
				<li>
				<span style="background-color:#ccc; font-weight:bold; font-size:18px; padding:10px 20px 10px 20px">wget https://raw.githubusercontent.com/cryptosam212/sam_dxo/master/install_dextro.sh</span><br>
				<br>
				<img src="https://raw.githubusercontent.com/cryptosam212/sam_dxo/master/putty3.png" width="600px" style="margin:10px"><br><br>
				</li>
				<li>
				<span style="background-color:#ccc; font-weight:bold; font-size:18px; padding:10px 20px 10px 20px">bash install_dextro.sh</span><br>
				<img src="https://raw.githubusercontent.com/cryptosam212/sam_dxo/master/putty4.png" width="600px" style="margin:10px"><br>
				<br>

</li>
				</ol>
				  </li>
				  <li>
				  Wait and follow the installing<br>
				<img src="https://raw.githubusercontent.com/cryptosam212/sam_dxo/master/putty5.png" width="600px" style="margin:10px"><br>
				<img src="https://raw.githubusercontent.com/cryptosam212/sam_dxo/master/putty6.png" width="600px" style="margin:10px"><br>
				  </li>
				<li>
				  copy and paste your private key that generated<br>
				<img src="https://raw.githubusercontent.com/cryptosam212/sam_dxo/master/putty7.png" width="600px" style="margin:10px"><br>
				Press Enter to continue<br>
				<img src="https://raw.githubusercontent.com/cryptosam212/sam_dxo/master/putty8.png" width="600px" style="margin:10px"><br>
				If your setup is finish you will see screen like below image<br>
				<img src="https://raw.githubusercontent.com/cryptosam212/sam_dxo/master/putty9.png" width="600px" style="margin:10px"><br>
				Congratulations..... Your Dextro Masternode setup VPS was done
				  </li>
				</ol></h3>

<h2 style="color: #25499A">Part 4: Masternode Activation</h2>
				<ol>
				  <h3><li>Enable Masternode</li></h3>
				  Restart your Windows Cold Wallet. From the top menu, go to Tools -&gt; Debug console<br>
				to acivate masternode, use command <strong>masternode start-alias MN_ALIAS</strong><br><br>

<span style="background-color:#ccc; font-weight:bold; font-size:18px; padding:10px 20px 10px 20px">masternode start-alias MN1</span>
				<br>
				<img src="http://dextro.io/images/start-masternode.png" width="600px" style="margin:10px"><br><br>
				if successfull we shown like this<br>
				<img src="http://dextro.io/images/start-masternode2.png" width="600px" style="margin:10px"><br><br>
				check at masternode tab and click update status for get newest status<br>
				<img src="http://dextro.io/images/start-masternode2a.png" width="600px" style="margin:10px"><br>
				if status enable, your masternode already activated. Check next 10minutes for active time must change forward.
				<br>

<h3><li>Check your MasterNode is enabled on VPS</li></h3>
				  <ol type="a">
				  <li>Check Mnsync status for check sync completed. <br><br>
				  <span style="background-color:#ccc; font-weight:bold; font-size:18px; padding:10px 20px 10px 20px;">dextro-cli mnsync status</span> <br><br>
				and report must contain  "IsBlockchainSynced" : true,<br><br>
				<br>

</li>
				<li>if already synced, check masternode status with :<br><br>
				<span style="background-color:#ccc; font-weight:bold; font-size:18px; padding:10px 20px 10px 20px">dextro-cli masternode status</span><br>
				<br>
				<img src="http://dextro.io/images/start-masternode3.png" width="600px" style="margin:10px"><br>
				report contain "status" : "Masternode successfully started"
				</li>
				  </ol>
				</ol>
				<p>&nbsp;</p>  
				<p>Congratulations, your masternode has been activated and running. Just wait for your first Dextro Masternode reward.</p> </div>
							<br />
