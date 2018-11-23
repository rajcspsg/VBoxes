#!/bin/bash
sudo yum install -y vim nano tar nmap ca-certificates net-tools zip unzip wget bind-utils
sudo su - vagrant
hostnamectl set-hostname test.com
