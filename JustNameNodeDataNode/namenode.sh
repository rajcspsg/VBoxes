#!/bin/bash
sudo yum install -y vim nano tar nmap ca-certificates net-tools zip unzip wget
sudo echo "%admin ALL=(ALL) ALL" >>sudo tee /etc/sudoers
sudo ssh-keygen -t dsa -P '' -f ~/.ssh/id_dsa
sudo cat ~/.ssh/id_dsa.pub >> ~/.ssh/authorized_keys

echo "192.168.10.34 datanode1.com
192.168.10.35 datanode2.com
192.168.10.33 snamenode.com
192.168.10.32 namenode.com" | sudo tee --append /etc/hosts

sudo cp /vagrant/jdk-8u181-linux-x64.rpm .
sudo rpm -ivh jdk-8u181-linux-x64.rpm
sudo cp /vagrant/hadoop-2.9.1.tar.gz .
sudo tar -xvzf hadoop-2.9.1.tar.gz

wget http://download.fedoraproject.org/pub/epel/6/x86_64/epel-release-6-8.noarch.rpm
rpm -ivh epel-release-6-8.noarch.rpm
yum --enablerepo=epel -y install sshpass

sudo echo "vagrant ALL=NOPASSWD: /home/vagrant/hadoop-2.9.1/sbin/start-dfs.sh" >> sudo tee /etc/sudoers

cd hadoop-2.9.1
sudo rm -rf etc/hadoop/slaves
sudo touch etc/hadoop/slaves
echo "datanode1.com
datanode2.com" | sudo tee --append /home/vagrant/hadoop-2.9.1/etc/hadoop/slaves

sudo rm -rf /home/vagrant/hadoop-2.9.1/etc/hadoop/hadoop-env.sh
sudo rm -rf /home/vagrant/hadoop-2.9.1/etc/hadoop/core-site.xml
sudo rm -rf /home/vagrant/hadoop-2.9.1/etc/hadoop/hdfs-site.xml

sudo cp /vagrant/hadoop-env.sh /home/vagrant/hadoop-2.9.1/etc/hadoop/
sudo cp /vagrant/core-site.xml /home/vagrant/hadoop-2.9.1/etc/hadoop/
sudo cp /vagrant/hdfs-site-nn.xml /home/vagrant/hadoop-2.9.1/etc/hadoop/hdfs-site.xml
