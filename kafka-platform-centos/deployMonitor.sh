#!/bin/bash
sudo yum install -y vim nano screen tar nmap ca-certificates net-tools zip unzip lsof git
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
cp  /vagrant/zookeeper-3.4.13.tar.gz /home/vagrant/Installed/
sudo tar -xvzf zookeeper-3.4.13.tar.gz

sudo curl -sSL https://get.docker.com/ | sh
sudo usermod -aG docker vagrant
sudo systemctl start docker

sudo curl -L https://github.com/docker/compose/releases/download/1.24.0/docker-compose-`uname -s`-`uname -m` -o /usr/local/bin/docker-compose
sudo chmod +x /usr/local/bin/docker-compose

#sudo usermod -aG docker $(whoami)

cp /vagrant/zoonavigator-docker-compose.yml /home/vagrant/Installed/
cp /vagrant/kafka-manager-docker-compose.yml /home/vagrant/Installed/

#sudo docker-compose -f kafka-manager-docker-compose.yml up -d
sudo docker-compose -f zoonavigator-docker-compose.yml up -d

sudo cp -r /vagrant/kafka-manager-1.3.3.21 /home/vagrant/Installed/
#unzip kafka-manager-1.3.3.21.zip
#cd kafka-manager-1.3.3.21

sudo git clone https://github.com/linkedin/kafka-monitor.git
#sudo wget https://github.com/prometheus/prometheus/releases/download/v2.9.2/prometheus-2.9.2.linux-amd64.tar.gz
sudo cp /vagrant/prometheus-2.9.2.linux-amd64.tar.gz Installed/
cd Installed
sudo tar -xzf prometheus-2.9.2.linux-amd64.tar.gz
sudo mv prometheus-2.9.2.linux-amd64 prometheus
sudo rm prometheus-*.linux-amd64.tar.gz
sudo chmod -R 777 /home/vagrant/Installed/prometheus/data
sudo chmod -R 777 /home/vagrant/Installed/prometheus/prometheus

export PROM_HOME=/home/vagrant/Installed/prometheus
echo "
[Unit]
Description= Prometheus Server
Documentation=https://prometheus.io/docs/introduction/overview/
After=network-online.target

[Service]
User=vagrant
ExecStart=$PROM_HOME/prometheus --config.file=$PROM_HOME/prometheus.yml --storage.tsdb.path=$PROM_HOME/data

[Install]
WantedBy=multi-user.target
" | sudo tee --append /etc/systemd/system/prometheus.service