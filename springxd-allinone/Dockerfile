FROM ubuntu:14.04
MAINTAINER Kashyap Parikh <kparikh@pivotal.io>

#install wget
RUN \
    apt-get update && \
    apt-get install -y software-properties-common wget

# install Oracle Java 7
RUN \
  echo debconf shared/accepted-oracle-license-v1-1 select true | debconf-set-selections && \
  echo debconf shared/accepted-oracle-license-v1-1 seen true | debconf-set-selections && \
  add-apt-repository -y ppa:webupd8team/java && \
  apt-get update && \
  apt-get install -y oracle-java7-installer && \
  rm -rf /var/cache/oracle-jdk7-installer

ENV JAVA_HOME /usr/lib/jvm/java-7-oracle

# install Zookeeper
RUN \
    wget -q -O - http://apache.mirrors.pair.com/zookeeper/zookeeper-3.4.6/zookeeper-3.4.6.tar.gz | tar -xzf - -C /opt && \
    cp /opt/zookeeper-3.4.6/conf/zoo_sample.cfg /opt/zookeeper-3.4.6/conf/zoo.cfg

# install Mysql
RUN DEBIAN_FRONTEND=noninteractive apt-get -y install mysql-server libmysql-java && \
    rm -rf /var/lib/mysql/mysql

# install Rabbitmq
RUN \
    DEBIAN_FRONTEND=noninteractive apt-get install -y rabbitmq-server && \
    rabbitmq-plugins enable rabbitmq_management


# install Redis
RUN \
  cd /tmp && \
  wget http://download.redis.io/redis-stable.tar.gz && \
  apt-get install -y build-essential make tar && \
  tar xvzf redis-stable.tar.gz && \
  cd redis-stable && \
  make && \
  make install && \
  cp -f src/redis-sentinel /usr/local/bin && \
  mkdir -p /etc/redis && \
  cp -f *.conf /etc/redis && \
  rm -rf /tmp/redis-stable* && \
  sed -i 's/^\(daemonize .*\)$/daemonize yes/' /etc/redis/redis.conf && \
  sed -i 's/^\(dir .*\)$/# \1\ndir \/var\/lib\/redis/' /etc/redis/redis.conf && \
  sed -i 's/^\(logfile .*\)$/logfile \/var\/log\/redis.log/' /etc/redis/redis.conf

# install Spring XD
RUN \
   apt-get install -y unzip && \
   cd /tmp && \
   wget -q http://deq44nzfzkcur.cloudfront.net/simple/libs-release-local/org/springframework/xd/spring-xd/1.0.0.RELEASE/spring-xd-1.0.0.RELEASE-dist.zip && \
   unzip -qq spring-xd-1.0.0.RELEASE-dist.zip -d / && \
   rm -rf /tmp/spring-xd-1.0.0.RELEASE-dist.zip && \
   ln -s /usr/share/java/mysql.jar /spring-xd-1.0.0.RELEASE/xd/lib/mysql.jar 

ADD env /env
ADD my.cnf /etc/mysql/conf.d/my.cnf
ADD mysqld_charset.cnf /etc/mysql/conf.d/mysqld_charset.cnf
ADD create_spring_batch_user_db.sh /create_spring_batch_user_db.sh
ADD start_mysql.sh /start_mysql.sh
ADD start_rabbitmq.sh /start_rabbitmq.sh
ADD startup.sh /startup.sh

RUN chmod 755 /*.sh /env
EXPOSE 2181 2888 3306 3888 5672 6379 9393 15672

CMD /startup.sh 
