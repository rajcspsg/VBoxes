#!/bin/bash

sudo yum install wget curl zip unzip tar gunzip  python3 vim -y

echo "192.168.33.10 aerospike1.com" | sudo tee --append /etc/hosts

hostnamectl set-hostname "aerospike1.com"

sudo wget https://download.aerospike.com/artifacts/aerospike-server-community/6.0.0.3/aerospike-server-community-6.0.0.3-el7.tgz
sudo tar -xvf aerospike-server-community-6.0.0.3-el7.tgz
cd aerospike-server-community-6.0.0.3-el7
sudo ./asinstall
sudo systemctl start aerospike &

wget https://github.com/aerospike-community/amc/releases/download/5.0.0/aerospike-amc-enterprise-5.0.0-1.x86_64.rpm
sudo rpm -i aerospike-amc-enterprise-5.0.0-1.x86_64.rpm
sudo service amc start
