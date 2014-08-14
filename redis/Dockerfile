FROM ubuntu:14.04
MAINTAINER Kashyap Parikh <kparikh@pivotal.io>

#install wget
RUN \
    apt-get update && \
    apt-get install -y software-properties-common wget

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
  mkdir -p /var/lib/redis && \
  echo "vm.overcommit_memory = 1" >> /etc/sysctl.conf && \
  cp -f *.conf /etc/redis && \
  rm -rf /tmp/redis-stable* && \
  sed -i 's/^\(daemonize .*\)$/daemonize no/' /etc/redis/redis.conf && \
  sed -i 's/^\(dir .*\)$/# \1\ndir \/var\/lib\/redis/' /etc/redis/redis.conf && \
  sed -i 's/^\(logfile .*\)$/logfile ""/' /etc/redis/redis.conf

EXPOSE 6379

CMD redis-server /etc/redis/redis.conf
