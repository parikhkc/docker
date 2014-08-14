FROM ubuntu:14.04
MAINTAINER Kashyap Parikh <kparikh@pivotal.io>

#install wget
RUN \
    apt-get update && \
    apt-get install -y software-properties-common wget

# install Rabbitmq
RUN \
    DEBIAN_FRONTEND=noninteractive apt-get install -y rabbitmq-server && \
    rabbitmq-plugins enable rabbitmq_management

ADD start_rabbitmq.sh /start_rabbitmq.sh

EXPOSE 5672 15672

CMD /start_rabbitmq.sh 
