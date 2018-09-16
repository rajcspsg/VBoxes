sudo apt-get update && \
      sudo apt-get -y install wget ca-certificates zip net-tools vim nano tar netcat

# Java Open JDK 8
sudo apt install -y openjdk-8-jdk


echo "192.168.10.35 kafka1
192.168.10.36 kafka2
192.168.10.37 kafka3
192.168.10.25 zookeeper1
192.168.10.26 zookeeper2
192.168.10.27 zookeeper3
192.168.10.52 monitor1" | sudo tee --append /etc/hosts

sudo cp /vagrant/kafka_2.12-1.1.1.tgz /home/vagrant/
sudo tar -xvzf kafka_2.12-1.1.1.tgz
sudo rm kafka_2.12-1.1.1.tgz
sudo mv kafka_2.12-1.1.1 kafka

cd kafka/
sudo cp /vagrant/zookeeper /etc/init.d/

sudo chmod +x /etc/init.d/zookeeper
sudo chown root:root /etc/init.d/zookeeper

sudo update-rc.d zookeeper defaults

sudo mkdir -p /data/zookeeper
sudo chown -R vagrant:vagrant /data/
echo "1" > /data/zookeeper/myid
sudo rm /home/vagrant/kafka/config/zookeeper.properties
sudo touch /home/vagrant/kafka/config/zookeeper.properties

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
server.1=zookeeper1:2888:3888
server.2=zookeeper2:2888:3888
server.3=zookeeper3:2888:3888' | sudo tee --append /home/vagrant/kafka/config/zookeeper.properties

sudo service zookeeper stop
#sudo service zookeeper start
