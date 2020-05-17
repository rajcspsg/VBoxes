sudo echo "%admin ALL=(ALL) ALL" >>sudo tee /etc/sudoers
sudo ssh-keygen -t dsa -P '' -f ~/.ssh/id_dsa
sudo cat ~/.ssh/id_dsa.pub >> ~/.ssh/authorized_keys

sudo hostnamectl standalone.hadoop.com
sudo cp /vagrant/jdk-8u181-linux-x64.rpm .
sudo rpm -ivh jdk-8u181-linux-x64.rpm
sudo cp /vagrant/hadoop-2.9.2.tar.gz .
sudo tar -xvzf hadoop-2.9.2.tar.gz

sudo echo "vagrant ALL=NOPASSWD: /home/vagrant/hadoop-2.9.1/sbin/start-dfs.sh" >> sudo tee /etc/sudoers
echo pwd
pwd
cd hadoop-2.9.2
sudo rm -rf /home/vagrant/hadoop-2.9.2/etc/hadoop/hadoop-env.sh
sudo rm -rf /home/vagrant/hadoop-2.9.2/etc/hadoop/core-site.xml
sudo rm -rf /home/vagrant/hadoop-2.9.2/etc/hadoop/hdfs-site.xml
sudo rm -rf /home/vagrant/hadoop-2.9.2/etc/hadoop/mapred-site.xml
sudo rm -rf /home/vagrant/hadoop-2.9.2/etc/hadoop/yarn-site.xml

sudo cp /vagrant/hadoop-env.sh /home/vagrant/hadoop-2.9.2/etc/hadoop/
sudo cp /vagrant/core-site.xml /home/vagrant/hadoop-2.9.2/etc/hadoop/
sudo cp /vagrant/hdfs-site.xml /home/vagrant/hadoop-2.9.2/etc/hadoop/
sudo cp /vagrant/mapred-site.xml /home/vagrant/hadoop-2.9.2/etc/hadoop/
sudo cp /vagrant/yarn-site.xml /home/vagrant/hadoop-2.9.2/etc/hadoop/

sudo bin/hdfs namenode -format -y
#sudo sbin/start-dfs.sh

sudo cp /vagrant/apache-hive-2.3.7-bin.tar.gz .
tar -xvzf apache-hive-2.3.7-bin.tar.gz
ln -s apache-hive-2.3.7-bin hive

export HIVE_HOME=/home/vagrant/hive
export PATH=$PATH:$HIVE_HOME/bin

export CLASSPATH=$CLASSPATH:/home/vagrant/hadoop-2.9.2/lib/*:$HIVE_HOME/lib/*

mkdir -p /home/vagrant/tmp /tmp/hive_io
HADOOP_PATH=/home/vagrant/hadoop-2.9.2/
export PATH=$PATH:$HADOOP_PATH/bin