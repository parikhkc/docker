FROM java:7
MAINTAINER Kashyap Parikh <kparikh@pivotal.io>

# TYPE can be release or snapshot
ENV TYPE release

# VERSION string 1.0.0.RELEASE, 1.0.1.BUILD-SNAPSHOT etc
ENV VERSION 1.0.0.RELEASE

# Create springio user and group
RUN groupadd -r springio && useradd -r -g springio springio

# download and unzip Spring XD
RUN \
   cd /tmp && \
   wget -q http://deq44nzfzkcur.cloudfront.net/simple/libs-${TYPE}-local/org/springframework/xd/spring-xd/${VERSION}/spring-xd-${VERSION}-dist.zip && \
   unzip -qq spring-xd-${VERSION}-dist.zip -d /opt && \
   rm -rf /tmp/spring-xd-${VERSION}-dist.zip && \
   chown -R springio:springio /opt/spring-xd-${VERSION} && \
   ln -s /opt/spring-xd-${VERSION} /opt/springxd

ADD startup.sh /opt/springxd/startup.sh

RUN chmod 755 /opt/springxd/startup.sh

USER springio
WORKDIR /opt/springxd

EXPOSE 9393

CMD ["startup.sh"]
