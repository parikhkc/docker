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
  apt-get install -q -y oracle-java7-installer && \
  rm -rf /var/cache/oracle-jdk7-installer

ENV JAVA_HOME /usr/lib/jvm/java-7-oracle

# install Zookeeper
RUN \
    wget -q -O - http://apache.mirrors.pair.com/zookeeper/zookeeper-3.4.6/zookeeper-3.4.6.tar.gz | tar -xzf - -C /opt && \
    cp /opt/zookeeper-3.4.6/conf/zoo_sample.cfg /opt/zookeeper-3.4.6/conf/zoo.cfg

EXPOSE 2181 2888 3888

CMD /opt/zookeeper-3.4.6/bin/zkServer.sh start-foreground
