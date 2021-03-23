apt install -y screen default-jdk nmap
sudo useradd -m -r -d /opt/minecraft minecraft
mkdir /opt/minecraft/survival
https://launcher.mojang.com/v1/objects/bb2b6b1aefcd70dfd1892149ac3a215f6c636b07/server.jar
sudo bash -c "echo eula=true > /opt/minecraft/survival/eula.txt" 
sudo chown -R minecraft /opt/minecraft/survival/
echo "[unit]
Description=Minecraft Server: %i
After=network.target
[Service]
WorkingDirectory=/opt/minecraft/%i
User=minecraft
Group=minecraft
Restart=always
ExecStart=/usr/bin/screen -DmS mc-%i /usr/bin/java -Xmx4G -jar minecraft_server.jar nogui
ExecStop=/usr/bin/screen -p 0 -S mc-%i -X eval 'stuff "say SERVER SHUTTING DOWN IN 5 SECONDS. SAVING ALL MAPS..."5'
ExecStop=/bin/sleep 5
ExecStop=/usr/bin/screen -p 0 -S mc-%i -X eval 'stuff "save-all"5'
ExecStop=/usr/bin/screen -p 0 -S mc-%i -X eval 'stuff "stop"5'
[Install]
WantedBy=multi-user.target" >/etc/systemd/system/minecraft@.service
systemctl enable minecraft@survival
ufw allow 25565/tcp
