#!/usr/bin/env bash
apt-get update
curl -fsSL https://get.docker.com | bash -s docker
apt install python3-pip -y
apt install zip unzip
bash <(wget -qO- https://git.io/JJYE0)
sudo curl -L "https://github.com/docker/compose/releases/download/2.5.0/docker-compose-linux-aarch64" -o /usr/local/bin/compose
chmod +x /usr/local/bin/compose
cat > docker-compose.yml <<EOF
version: "2.1"
services:
  qbittorrent:
    image: linuxserver/qbittorrent:14.3.6.99202107121017-7389-3ac8c97e6ubuntu20.04.1-ls148
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
