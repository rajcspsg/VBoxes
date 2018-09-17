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
192.168.10.51 kafkamisc
192.168.10.52 monitor1" | sudo tee --append /etc/hosts

sudo mkdir -p Installed
cd Installed
