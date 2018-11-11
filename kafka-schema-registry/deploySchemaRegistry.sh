#!/bin/bash
sudo yum install -y vim nano tar nmap ca-certificates net-tools zip unzip lsof
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

sudo mkdir -p Installed
sudo cp /vagrant/confluent-oss-5.0.1-2.11.tar.gz ./Installed/
cd Installed

sudo tar -xvzf confluent-oss-5.0.1-2.11.tar.gz
cd confluent-5.0.1
sudo cp /vagrant/schema-registry$1.properties etc/schema-registry/schema-registry.properties
sudo bin/schema-registry-start  -daemon etc/schema-registry/schema-registry.properties
