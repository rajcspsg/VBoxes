wget http://packages.confluent.io/archive/5.0/confluent-oss-5.0.1-2.11.tar.gz
wget http://packages.confluent.io/archive/5.0/confluent-oss-5.0.1-2.11.tar.gz

vagrant up

once done `vagrant ssh kafkamisc.com`
    cd `Installed/kafka-manager-1.3.3.21/conf`
    edit ZK_HOSTS property using`sudo vi application.conf` and set the property value to `zookeeper1.com:2181,zookeeper2.com:2181,zookeeper3.com:2181/kafka`
    start bin/kafka-manager