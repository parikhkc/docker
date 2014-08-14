Spring XD on Docker
===================

[Spring XD](http://projects.spring.io/spring-xd) is an open source project from [Pivotal](http://pivotal.io), targeted to simplify the development of big data applications. Application developers can use Spring XD to solve common big data problems such as data ingestion and export, real-time analytics, and batch workflow orchestration.

This project provides dockerized images of Spring XD components. Currently all images are built on top of Ubuntu 14.04 base. There are two ways to run Spring XD. Singlenode and Distributed.

### Singlenode
Singlenode is targated mainly for app developers who wants to design data analytics and ingestion scenarios on their laptop. It runs Spring XD and required middleware in a single jvm.

```
# pull image (one time)
docker pull kparikh/springxd-singlenode

# start xd
docker run -t -d --name xd-singlenode -P kparikh/springxd-singlenode
```

You can inspect ip/port of XD and connect to it via xd-shell.

Look under Ports colomn in the result of `docker ps -l` for xd-singlenode port. Connect using xd-shell.

### Distributed
Typically you will want to distribute Spring XD processing tasks across multiple nodes based on cpu, network and io affinity of your architecture.

For distributed deployment you need to deploy required middleware and wire connection config to Spring XD Admin and Container. We will use docker links to simplify the wiring. Here's the list of middleware for XD, you don't have to use the same middleware or the images provided here.

*MySQL*: DBMS for Spring Batch Jobs
*RabbitMQ*: For Spring XD Data Transport 
*Redis*: Spring XD analytics repository
*Zookeeper*: For Spring XD deployment orchestration, HA and fault tolerance

```
# pull all images middleware and spring xd (one time)
docker pull kparikh/mysql
docker pull kparikh/rabbitmq
docker pull kparikh/redis
docker pull kparikh/zookeeper
docker pull kparikh/springxd

# run middleware
docker run -d -t --name mysql kparikh/mysql
docker run -d -t --name rabbitmq kparikh/rabbitmq
docker run -d -t --name redis kparikh/redis
docker run -d -t --name zk kparikh/zookeeper

# start container(s) and admin(s)
docker run -d -t -P --name container1 --link mysql:mysql --link redis:redis --link rabbitmq:rabbitmq --link zk:zk kparikh/springxd

docker run -d -t -P --name admin --link mysql:mysql --link redis:redis --link rabbitmq:rabbitmq --link zk:zk kparikh/springxd /admin 

```

Find out Admin server port `docker ps -l` and connect using xd-shell.


