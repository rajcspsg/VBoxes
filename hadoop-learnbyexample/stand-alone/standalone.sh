sudo echo "%admin ALL=(ALL) ALL" >>sudo tee /etc/sudoers
sudo ssh-keygen -t dsa -P '' -f ~/.ssh/id_dsa
sudo cat ~/.ssh/id_dsa.pub >> ~/.ssh/authorized_keys

sudo cp /vagrant/jdk-8u181-linux-x64.rpm .
sudo rpm -ivh jdk-8u181-linux-x64.rpm
sudo cp /vagrant/hadoop-2.9.1.tar.gz .
sudo tar -xvzf hadoop-2.9.1.tar.gz

sudo echo "vagrant ALL=NOPASSWD: /home/vagrant/hadoop-2.9.1/sbin/start-dfs.sh" >> sudo tee /etc/sudoers

cd hadoop-2.9.1
sudo rm -rf /home/vagrant/hadoop-2.9.1/etc/hadoop/hadoop-env.sh
sudo rm -rf /home/vagrant/hadoop-2.9.1/etc/hadoop/core-site.xml
sudo rm -rf /home/vagrant/hadoop-2.9.1/etc/hadoop/hdfs-site.xml
sudo rm -rf /home/vagrant/hadoop-2.9.1/etc/hadoop/mapred-site.xml
sudo rm -rf /home/vagrant/hadoop-2.9.1/etc/hadoop/yarn-site.xml

sudo cp /vagrant/hadoop-env.sh /home/vagrant/hadoop-2.9.1/etc/hadoop/
sudo cp /vagrant/core-site.xml /home/vagrant/hadoop-2.9.1/etc/hadoop/
sudo cp /vagrant/hdfs-site.xml /home/vagrant/hadoop-2.9.1/etc/hadoop/
sudo cp /vagrant/mapred-site.xml /home/vagrant/hadoop-2.9.1/etc/hadoop/
sudo cp /vagrant/yarn-site.xml /home/vagrant/hadoop-2.9.1/etc/hadoop/

sudo bin/hdfs namenode -format
#sudo sbin/start-dfs.sh