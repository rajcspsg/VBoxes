#!/bin/bash
vagrant up
vagrant ssh zookeeper1.com -- -t 'sudo service zookeeper status'
vagrant ssh zookeeper2.com -- -t 'sudo service zookeeper status'
vagrant ssh zookeeper3.com -- -t 'sudo service zookeeper status'

vagrant ssh kafka1.com -- -t 'sudo service kafka status'
vagrant ssh kafka2.com -- -t 'sudo service kafka status'
vagrant ssh kafka3.com -- -t 'sudo service kafka status'