#!/usr/bin/env bash
apt-get update
apt install docker.io -y
apt install python3-pip -y
apt install zip unzip
bash <(wget -qO- https://git.io/JJYE0)
sudo curl -L "https://github.com/docker/compose/releases/download/1.29.2/docker-compose-$(uname -s)-$(uname -m)" -o /usr/local/bin/docker-compose
chmod a+x /usr/local/bin/docker-compose
cat > docker-compose.yml <<EOF
version: "2.1"
services:
  qbittorrent:
    image: linuxserver/qbittorrent:14.3.5.99202106211645-7376-e25948e73ubuntu20.04.1-ls140
    container_name: qb
    environment:
      - PUID=1000
      - PGID=1000
      - TZ=Asia/Singapore
      - WEBUI_PORT=8080
    volumes:
      - /root/.config:/config
      - /usr/bin/fclone:/usr/local/bin/fclone
      - /root:/root
      - /home:/home
    network_mode: host
    restart: unless-stopped
EOF
docker-compose up -d
mkdir -p /home/zeus
chmod -R 777 /home/zeus /root
docker exec -it qb apt-get update
docker exec -it qb apt install python3-pip -y
docker exec -it qb pip3 install requests
docker exec -it qb pip3 install qbittorrent-api
