# start NameNode, Secondary NameNode and DataNode
    `sudo sbin/start-dfs.sh`

# Creating files in HDFS

    `sudo bin/hdfs  dfs -mkdir /user/vagrant`

# Starting yarn applications
    `sudo sbin/start-yarn.sh`

# Running example grep applications
    `sudo bin/hdfs dfs -mkdir /input`    -- creates the directory
    `sudo bin/hdfs dfs -put etc/hadoop/* /input/` -- copies the files into hdfs
    `sudo bin/hdfs dfs -ls /input/`  -- list the files in hdfs
    `sudo bin/hadoop jar share/hadoop/mapreduce/hadoop-mapreduce-examples-2.9.1.jar grep /input /output 'dfs[a-z.]+'` # command to run map reduce
    `sudo bin/hdfs dfs -cat /output/*`



    sudo bin/hadoop fs -help
