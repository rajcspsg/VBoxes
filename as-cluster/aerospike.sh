#!/bin/bash

sudo yum install wget curl zip unzip tar gunzip  python3 vim logrotate net-tools -y

echo "192.168.10.25 aerospike1.com
192.168.10.26 aerospike2.com
192.168.10.27 aerospike3.com" | sudo tee --append /etc/hosts

hostnamectl set-hostname "aerospike$2.com"
sudo mkdir -p /var/log/aerospike

sudo wget https://download.aerospike.com/artifacts/aerospike-server-community/6.0.0.3/aerospike-server-community-6.0.0.3-el7.tgz
sudo tar -xvf aerospike-server-community-6.0.0.3-el7.tgz
cd aerospike-server-community-6.0.0.3-el7
sudo ./asinstall
sudo mv /vagrant/aerospike$2.conf /etc/aerospike/aerospike.conf
sudo systemctl start aerospike &
