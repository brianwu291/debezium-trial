#!/bin/sh

docker run -it --rm --name zookeeper -p 2181:2181 -p 2888:2888 -p 3888:3888 quay.io/debezium/zookeeper:2.7

docker run -it --rm --name kafka -p 9092:9092 --link zookeeper:zookeeper quay.io/debezium/kafka:2.7

docker run -it --rm --name psql -p 5432:5432 -e ROOT_PASSWORD=debezium -e POSTGRES_USER=postgres -e POSTGRES_PASSWORD=postgres quay.io/debezium/example-postgres:2.7

docker run -it --rm --name connect -p 8083:8083 -e GROUP_ID=1 -e CONFIG_STORAGE_TOPIC=my_connect_configs -e OFFSET_STORAGE_TOPIC=my_connect_offsets -e STATUS_STORAGE_TOPIC=my_connect_statuses --link kafka:kafka --link psql:psql quay.io/debezium/connect:2.7
