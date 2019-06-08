sudo apt update

# install transmission
sudo apt install transmission-daemon
sudo usermod -a -G debian-transmission erfan

# create download folders
mkdir $HOME/totally_legal_stuff
mkdir $HOME/totally_legal_stuff/shared
mkdir $HOME/totally_legal_stuff/shows
mkdir $HOME/totally_legal_stuff/movies
mkdir $HOME/totally_legal_stuff/other

sudo chgrp -R debian-transmission $HOME/totally_legal_stuff
sudo chmod -R 775 $HOME/totally_legal_stuff

# backup transmission settings
sudo cp -a /etc/transmission-daemon/settings.json /etc/transmission-daemon/settings.json.default

# install docker
sudo apt-get install \
    apt-transport-https \
    ca-certificates \
    curl \
    gnupg-agent \
    software-properties-common
curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo apt-key add -
sudo add-apt-repository \
   "deb [arch=amd64] https://download.docker.com/linux/ubuntu \
   $(lsb_release -cs) \
   stable"
sudo apt-get update
sudo apt-get install docker-ce docker-ce-cli containerd.io

# install docker compose (maybe change version)
sudo curl -L "https://github.com/docker/compose/releases/download/1.24.0/docker-compose-$(uname -s)-$(uname -m)" -o /usr/local/bin/docker-compose

# run filemanager
sudo docker run -d \
    -v $HOME/totally_legal_stuff:/srv \
    -p 9000:80 \
    filebrowser/filebrowser

# download caddy
mkdir /tmp/caddy-dl
wget "https://caddyserver.com/download/linux/amd64?license=personal&telemetry=off" -O - | tar -xz -C /tmp/caddy-dl
sudo cp /tmp/caddy-dl/caddy /usr/local/bin/caddy
sudo setcap cap_net_bind_service=+ep /usr/local/bin/caddy

sudo cp $HOME/dotfiles/Caddyfile /etc/caddy/
sudo chown root:root /etc/caddy/Caddyfile
sudo chmod 644 /etc/caddy/Caddyfile

sudo mkdir -p /var/log/caddy
sudo chown www-data:www-data /var/log/caddy
sudo chmod 750 /var/log/caddy

sudo wget -O /etc/systemd/system/caddy.service "https://raw.githubusercontent.com/mholt/caddy/master/dist/init/linux-systemd/caddy.service"
sudo chown root:root /etc/systemd/system/caddy.service
sudo chmod 644 /etc/systemd/system/caddy.service
sudo systemctl daemon-reload

echo "
TODO:
Edit /etc/transmission-daemon/settings.json (change download dir, user/pass)
Then run sudo systemctl reload transmission-daemon.service

Download plex from https://www.plex.tv/media-server-downloads/ and sudo dpkg -i plex*.deb to install
Then set it up with ssh tunnel, ssh <SERVER_IP> -L 8888:localhost:32400

Add email to caddy.service, modify caddyfile then start caddy

Change the filebrowser username and password
"
