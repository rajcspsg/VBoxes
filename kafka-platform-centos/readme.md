need to install kafka manager on kafkamonitor.com
    
update conf/application.conf with
    `zookeeper1.com:2181,zookeeper2.com:2181,zookeeper3.com:2181/kafka`

need to to install kafka schema registry on kafkamisc.com

bin/kafka-topics.sh --create --zookeeper zookeeper1.com:2181,zookeeper2.com:2181,zookeeper3.com:2181/kafka --replication-factor 1 --partitions 1 --topic streams-plaintext-input

bin/kafka-topics.sh --zookeeper zookeeper1.com:2181,zookeeper2.com:2181,zookeeper3.com:2181/kafka --list

bin/kafka-console-producer.sh --broker-list kafka1.com:9092,kafka2.com:9092,kafka3.com:9092 --topic streams-plaintext-input


bin/kafka-console-consumer.sh --bootstrap-server kafka1.com:9092,kafka2.com:9092,kafka3.com:9092 --topic streams-plaintext-input --from-beginning

bin/kafka-console-consumer.sh --bootstrap-server kafka1.com:9092,kafka2.com:9092,kafka3.com:9092 --topic word-count-output --from-beginning --formatter kafka.tools.DefaultMessageFormatter --property print.key=true --property print.value=true --property key.deserializer=org.apache.kafka.common.serialization.StringDeserializer --property value.deserializer=org.apache.kafka.common.serialization.LongDeserializer


bin/kafka-run-class.sh org.apache.kafka.streams.examples.wordcount.WordCountDemo


bin/kafka-console-consumer.sh --bootstrap-server kafka1.com:9092,kafka2.com:9092,kafka3.com:9092 --topic streams-wordcount-output --from-beginning
