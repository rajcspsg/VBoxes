#!/bin/bash
sudo yum install -y vim nano tar nmap ca-certificates net-tools
sudo yum install -y java-1.8.0-openjdk

echo "192.168.10.25 zookeeper1.com
192.168.10.26 zookeeper2.com
192.168.10.27 zookeeper3.com
192.168.10.34 datanode1.com
192.168.10.35 datanode2.com
192.168.10.36 datanode3.com
192.168.10.33 snamenode.com
192.168.10.32 namenode.com
192.168.10.52 clustermonitor.com" | sudo tee --append /etc/hosts

sudo cp /vagrant/zookeeper-3.4.13.tar.gz /home/vagrant/
sudo tar -xvzf zookeeper-3.4.13.tar.gz
sudo rm zookeeper-3.4.13.tar.gz
sudo mv zookeeper-3.4.13 zookeeper

sudo cd zookeeper/
sudo cp /vagrant/zookeeper /etc/init.d/

sudo chmod +x /etc/init.d/zookeeper
sudo chown root:root /etc/init.d/zookeeper

sudo mkdir -p /data/zookeeper
sudo chown -R vagrant:vagrant /data/
sudo echo $1 > /data/zookeeper/myid
sudo touch /home/vagrant/zookeeper/conf/zoo.cfg

echo '# the location to store the in-memory database snapshots and, unless specified otherwise, the transaction log of updates to the database.
dataDir=/data/zookeeper
# the port at which the clients will connect
clientPort=2181
# disable the per-ip limit on the number of connections since this is a non-production config
maxClientCnxns=0
# the basic time unit in milliseconds used by ZooKeeper. It is used to do heartbeats and the minimum session timeout will be twice the tickTime.
tickTime=2000
# The number of ticks that the initial synchronization phase can take
initLimit=10
# The number of ticks that can pass between
# sending a request and getting an acknowledgement
syncLimit=5
# zoo servers
# these hostnames such as `zookeeper-1` come from the /etc/hosts file
server.1=zookeeper1.com:2888:3888
server.2=zookeeper2.com:2888:3888
server.3=zookeeper3.com:2888:3888' | sudo tee --append /home/vagrant/zookeeper/conf/zoo.cfg

#service zookeeper stop
sudo service zookeeper start
