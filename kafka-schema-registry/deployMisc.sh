#!/bin/bash
sudo yum install -y vim nano tar nmap ca-certificates net-tools zip unzip
sudo yum install -y java-1.8.0-openjdk

echo "192.168.10.35 kafka1.com
192.168.10.36 kafka2.com
192.168.10.37 kafka3.com
192.168.10.25 zookeeper1.com
192.168.10.26 zookeeper2.com
192.168.10.27 zookeeper3.com
192.168.10.45 schemaregistry1.com
192.168.10.46 schemaregistry2.com
192.168.10.47 schemaregistry3.com
192.168.10.51 kafkamisc.com" | sudo tee --append /etc/hosts

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

cp /vagrant/zoonavigator-docker-compose.yml /home/vagrant/Installed/
#cp /vagrant/kafka-manager-docker-compose.yml /home/vagrant/Installed/

#sudo docker-compose -f kafka-manager-docker-compose.yml up -d
docker-compose -f zoonavigator-docker-compose.yml up -d

sudo cp -r /vagrant/kafka-manager-1.3.3.21 /home/vagrant/Installed/

sudo docker pull landoop/schema-registry-ui
sudo docker run -d --net=host -p 8000:8000 \
           -e "SCHEMAREGISTRY_URL=http://schemaregistry1.com:8081" \
           landoop/schema-registry-ui

