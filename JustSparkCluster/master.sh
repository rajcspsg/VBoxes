#!/bin/bash
sudo yum install -y vim nano tar nmap ca-certificates net-tools zip unzip wget bind-utils openssh-server openssh-clients openssh
sudo echo "%admin ALL=(ALL) ALL" >>sudo tee /etc/sudoers
ssh-keygen -t dsa -P '' -f ~/.ssh/id_dsa
cat ~/.ssh/id_dsa.pub >> ~/.ssh/authorized_keys
ssh-keygen -t rsa -P "" -f ~/.ssh/id_rsa
cat ~/.ssh/id_rsa.pub >> ~/.ssh/authorized_keys

echo "192.168.11.34 slave1.com
192.168.11.35 slave2.com
192.168.11.36 slave3.com
192.168.11.33 master.com" | sudo tee --append /etc/hosts

hostnamectl set-hostname "master.com"
wget http://download.fedoraproject.org/pub/epel/6/x86_64/epel-release-6-8.noarch.rpm
rpm -ivh epel-release-6-8.noarch.rpm
yum --enablerepo=epel -y install sshpass

sudo cp /vagrant/jdk-8u181-linux-x64.rpm .
sudo rpm -ivh jdk-8u181-linux-x64.rpm
sudo cp /vagrant/scala-2.12.6.rpm .
sudo rpm -ivh scala-2.12.6.rpm

sudo cp /vagrant/spark-2.4.0-bin-hadoop2.7.tgz .
sudo tar -xvzf spark-2.4.0-bin-hadoop2.7.tgz

sudo cp /vagrant/spark-env.sh /home/vagrant/spark-2.4.0-bin-hadoop2.7/conf/
sudo cp /vagrant/slaves /home/vagrant/spark-2.4.0-bin-hadoop2.7/conf/
echo "export PATH = $PATH:/home/vagrant/spark-2.4.0-bin-hadoop2.7/bin" | sudo tee --append ~/.bashrc
source ~/.bashrc
