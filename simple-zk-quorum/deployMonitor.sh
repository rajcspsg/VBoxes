#!/bin/bash
sudo yum install -y vim nano tar nmap ca-certificates net-tools zip unzip
sudo yum install -y java-1.8.0-openjdk

echo "192.168.10.25 zookeeper1.com
192.168.10.26 zookeeper2.com
192.168.10.27 zookeeper3.com
192.168.10.52 clustermonitor.com" | sudo tee --append /etc/hosts

mkdir -p Installed
cd Installed
cp  /vagrant/zookeeper-3.4.13.tar.gz /home/vagrant/Installed/
sudo tar -xvzf zookeeper-3.4.13.tar.gz

mkdir -p Installed
cd Installed

sudo curl -sSL https://get.docker.com/ | sh
sudo usermod -aG docker vagrant
sudo systemctl start docker

sudo curl -L "https://github.com/docker/compose/releases/download/1.22.0/docker-compose-$(uname -s)-$(uname -m)" -o /usr/local/bin/docker-compose
sudo chmod +x /usr/local/bin/docker-compose
sudo chown -R vagrant:vagrant /usr/local/bin/docker-compose
sudo chown -R root:root /usr/local/bin/docker-compose
docker-compose -f zoonavigator-docker-compose.yml up -d

cp /vagrant/zoonavigator-docker-compose.yml /home/vagrant/Installed/
