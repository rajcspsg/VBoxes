#!/bin/bash

sudo yum install wget curl zip unzip tar gunzip  python3 vim -y

echo "192.168.10.25 aerospike1.com
192.168.10.26 aerospike2.com
192.168.10.27 aerospike3.com
192.168.33.10 amc.com" | sudo tee --append /etc/hosts

hostnamectl set-hostname "amc.com"

wget https://github.com/aerospike-community/amc/releases/download/5.0.0/aerospike-amc-enterprise-5.0.0-1.x86_64.rpm
sudo rpm -i aerospike-amc-enterprise-5.0.0-1.x86_64.rpm
sudo service amc start