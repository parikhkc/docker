#!/bin/bash

docker run -t -d --link mysql:mysql --link redis:redis --link rabbitmq:rabbitmq --link zk:zk kparikh/springxd-distributed:1.0.0 /admin
