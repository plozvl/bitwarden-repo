#!/bin/bash

ip=$(ifconfig | awk '/^eth0:/,/^$/' |awk 'NR==2 {print $2}')

yes | sudo dnf install -y dnf-plugins-core
yes | sudo dnf config-manager --add-repo https://download.docker.com/linux/fedora/docker-ce.repo
sudo dnf install docker-ce docker-ce-cli containerd.io docker-compose-plugin docker-compose -y
sudo systemctl start docker
sudo systemctl enable docker
yes | sudo dnf install docker-compose
curl -Lso bitwarden.sh https://go.btwrdn.co/bw-sh
sudo chmod +x bitwarden.sh
xdg-open https://bitwarden.com/host
read -p "Enter your install id:" id
read -p "Enter your install key:" key
sudo ./bitwarden.sh install << EOF
$ip
n
vault
$id
$key
US
N
y
EOF

sleep 5

./bitwarden.sh start
xdg-open http://${ip}