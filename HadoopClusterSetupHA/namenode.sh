#!/bin/bash
#sudo su - vagrant
sudo yum install -y vim nano tar nmap ca-certificates net-tools zip unzip wget bind-utils
sudo echo "%admin ALL=(ALL) ALL" >>sudo tee /etc/sudoers
ssh-keygen -t dsa -P '' -f ~/.ssh/id_dsa
cat ~/.ssh/id_dsa.pub >> ~/.ssh/authorized_keys

echo "192.168.10.25 zookeeper1.com
192.168.10.26 zookeeper2.com
192.168.10.27 zookeeper3.com
192.168.10.34 datanode1.com
192.168.10.35 datanode2.com
192.168.10.36 datanode3.com
192.168.10.33 snamenode.com
192.168.10.32 namenode.com" | sudo tee --append /etc/hosts

sudo cp /vagrant/jdk-8u181-linux-x64.rpm .
sudo rpm -ivh jdk-8u181-linux-x64.rpm
sudo cp /vagrant/hadoop-2.9.1.tar.gz .
sudo tar -xvzf hadoop-2.9.1.tar.gz

hostnamectl set-hostname "namenode.com"
wget http://download.fedoraproject.org/pub/epel/6/x86_64/epel-release-6-8.noarch.rpm
rpm -ivh epel-release-6-8.noarch.rpm
yum --enablerepo=epel -y install sshpass

sudo mkdir -p /data/mycluster
sudo echo "vagrant ALL=NOPASSWD: /home/vagrant/hadoop-2.9.1/sbin/start-dfs.sh" >> sudo tee /etc/sudoers

cd hadoop-2.9.1
sudo rm -rf etc/hadoop/slaves
sudo touch etc/hadoop/slaves
echo "datanode1.com
datanode2.com
datanode3.com" | sudo tee --append /home/vagrant/hadoop-2.9.1/etc/hadoop/slaves

sudo rm -rf /home/vagrant/hadoop-2.9.1/etc/hadoop/hadoop-env.sh
sudo rm -rf /home/vagrant/hadoop-2.9.1/etc/hadoop/core-site.xml
sudo rm -rf /home/vagrant/hadoop-2.9.1/etc/hadoop/hdfs-site.xml
sudo rm -rf /home/vagrant/hadoop-2.9.1/etc/hadoop/mapred-site.xml
sudo rm -rf /home/vagrant/hadoop-2.9.1/etc/hadoop/yarn-site.xml

sudo cp /vagrant/hadoop-env.sh /home/vagrant/hadoop-2.9.1/etc/hadoop/
sudo cp /vagrant/core-site.xml /home/vagrant/hadoop-2.9.1/etc/hadoop/
sudo cp /vagrant/hdfs-site-nn.xml /home/vagrant/hadoop-2.9.1/etc/hadoop/hdfs-site.xml
sudo cp /vagrant/mapred-site.xml /home/vagrant/hadoop-2.9.1/etc/hadoop/
sudo cp /vagrant/yarn-site.xml /home/vagrant/hadoop-2.9.1/etc/hadoop/

cp /vagrant/spark-2.4.0-bin-without-hadoop-scala-2.12.tgz /home/vagrant/
cd /home/vagrant/
tar -xvzf spark-2.4.0-bin-without-hadoop-scala-2.12.tgz
mv spark-2.4.0-bin-without-hadoop-scala-2.12 spark
cp /home/vagrant/spark/jars/spark-network-shuffle_2.12-2.4.0.jar /home/vagrant/hadoop-2.9.1/share/hadoop/yarn/lib
cp /home/vagrant/spark/conf/spark-env.sh.template /home/vagrant/spark/conf/spark-env.sh
cp /home/vagrant/spark/conf/spark-defaults.conf.template /home/vagrant/spark/conf/spark-defaults.conf

echo "spark.master                yarn
spark.eventLog.enabled            true
spark.driver.memory               512m
spark.serializer                  org.apache.spark.serializer.KyroSerializer
spark.eventLog.dir                hdfs://namenode.com:9000/spark_logs
spark.history.fs.logDirectory     hdfs://namenode.com:9000/spark_logs
spark.history.provider            org.apache.spark.deploy.history.FsHistoryProvider
spark.history.fs.update.interval  10s" | sudo tee --append /home/vagrant/spark/conf/spark-defaults.conf

cd spark

echo "export HADOOP_HOME=/home/vagrant/hadoop-2.9.1
export HADOOP_MAPRED_HOME=$HADOOP_HOME
export HADOOP_COMMON_HOME=$HADOOP_HOME
export HADOOP_HDFS_HOME=$HADOOP_HOME
export YARN_HOME=$HADOOP_HOME
export HADOOP_CONF_DIR=$HADOOP_HOME/etc/hadoop
export YARN_CONF_DIR=$HADOOP_HOME/etc/hadoop
export JAVA_HOME=/usr/java/latest
export SPARK_HOME=/home/vagrant/spark
export LD_LIBRARY_PATH=/home/vagrant/hadoop-2.9.1/lib/native:$LD_LIBRARY_PATH
PATH=$SPARK_HOME/bin:$HADOOP_HOME/bin:$HADOOP_HOME/sbin:$JAVA_HOME/bin:$PATH
export PATH=$PATH" | sudo tee --append ~/.bashrc

echo "
export SPARK_DIST_CLASSPATH=$(hadoop classpath)" | sudo tee --append /home/vagrant/spark/conf/spark-env.sh

cp /home/vagrant/spark/yarn/spark-2.4.0-yarn-shuffle.jar /home/vagrant/hadoop-2.9.1/share/hadoop/yarn/lib/

