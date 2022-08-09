#!/bin/bash

sudo yum install wget curl zip unzip tar gunzip  python3 -y
sudo wget https://download.aerospike.com/artifacts/aerospike-server-community/6.0.0.3/aerospike-server-community-6.0.0.3-el7.tgz
sudo tar -xvf aerospike-server-community-6.0.0.3-el7.tgz
cd aerospike-server-community-6.0.0.3-el7
sudo ./asinstall
sudo systemctl start aerospike &
