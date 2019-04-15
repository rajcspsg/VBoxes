#!/bin/bash
sudo yum install -y vim nano tar screen nmap ca-certificates net-tools zip unzip
sudo yum install -y java-1.8.0-openjdk


echo "192.168.10.35 kafka1.com
192.168.10.36 kafka2.com
192.168.10.37 kafka3.com
192.168.10.25 zookeeper1.com
192.168.10.26 zookeeper2.com
192.168.10.27 zookeeper3.com
192.168.10.51 kafkamisc.com
192.168.10.52 kafkamonitor.com" | sudo tee --append /etc/hosts

mkdir -p Installed
cd Installed

sudo curl -sSL https://get.docker.com/ | sh
sudo usermod -aG docker vagrant
sudo systemctl start docker

sudo curl -L "https://github.com/docker/compose/releases/download/1.22.0/docker-compose-$(uname -s)-$(uname -m)" -o /usr/local/bin/docker-compose
sudo chmod +x /usr/local/bin/docker-compose

sudo docker pull landoop/schema-registry-ui
sudo docker run -d --net=host -p 8000:8000 \
           -e "SCHEMAREGISTRY_URL=http://kafkamisc.com:8081" \
           landoop/schema-registry-ui
