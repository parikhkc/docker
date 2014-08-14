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

# install Spring XD
RUN \
   apt-get install -y unzip && \
   cd /tmp && \
   wget -q http://deq44nzfzkcur.cloudfront.net/simple/libs-release-local/org/springframework/xd/spring-xd/1.0.0.RELEASE/spring-xd-1.0.0.RELEASE-dist.zip && \
   unzip -qq spring-xd-1.0.0.RELEASE-dist.zip -d / && \
   rm -rf /tmp/spring-xd-1.0.0.RELEASE-dist.zip

# install mysql driver
Run \
   apt-get install -y libmysql-java && \ 
   ln -s /usr/share/java/mysql.jar /spring-xd-1.0.0.RELEASE/xd/lib/mysql.jar

ADD admin /admin
ADD container /container
ADD env /env

RUN chmod 755 /admin /container /env
EXPOSE 9393

CMD /container
