#!/bin/bash
sudo yum install -y vim nano tar nmap ca-certificates net-tools
sudo yum install -y java-1.8.0-openjdk

echo "192.168.10.35 kafka1.com
192.168.10.36 kafka2.com
192.168.10.37 kafka3.com
192.168.10.25 zookeeper1.com
192.168.10.26 zookeeper2.com
192.168.10.27 zookeeper3.com
192.168.10.51 kafkamisc.com
192.168.10.52 kafkamonitor.com" | sudo tee --append /etc/hosts

sudo mkdir -p /data/kafka
sudo chown -R vagrant:vagrant /data/kafka
echo "* hard nofile 100000
* soft nofile 100000" | sudo tee --append /etc/security/limits.conf


sudo cp /vagrant/kafka_2.12-1.1.1.tgz /home/vagrant/
sudo tar -xvzf kafka_2.12-1.1.1.tgz
sudo rm kafka_2.12-1.1.1.tgz
sudo mv kafka_2.12-1.1.1 kafka

sudo cd kafka/
sudo rm -rf config/server.properties
sudo cp /vagrant/server2.properties config/server.properties

sudo cp /vagrant/kafka /etc/init.d/
sudo chmod +x /etc/init.d/kafka
sudo chown root:root /etc/init.d/kafka
# you can safely ignore the warning
#sudo update-rc.d kafka defaults
sudo service kafka start
