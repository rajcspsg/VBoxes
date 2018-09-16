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

sudo apt-get install -y xfsprogs
sudo mkdir -p /data/kafka
sudo chown -R vagrant:vagrant /data/kafka
echo "* hard nofile 100000
* soft nofile 100000" | sudo tee --append /etc/security/limits.conf


sudo cp /vagrant/kafka_2.12-1.1.1.tgz /home/vagrant/
sudo tar -xvzf kafka_2.12-1.1.1.tgz
sudo rm kafka_2.12-1.1.1.tgz
sudo mv kafka_2.12-1.1.1 kafka

cd kafka/
sudo rm config/server.properties
sudo cp /vagrant/server3.properties config/server.properties

sudo cp /vagrant/kafka /etc/init.d/
sudo chmod +x /etc/init.d/kafka
sudo chown root:root /etc/init.d/kafka
# you can safely ignore the warning
sudo update-rc.d kafka defaults
#sudo service kafka start
