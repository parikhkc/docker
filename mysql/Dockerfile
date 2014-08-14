FROM ubuntu:14.04
MAINTAINER Kashyap Parikh <kparikh@pivotal.io>

# install Mysql
RUN \
    apt-get update && \
    DEBIAN_FRONTEND=noninteractive apt-get -y install mysql-server && \
    rm -rf /var/lib/mysql/mysql

ADD my.cnf /etc/mysql/conf.d/my.cnf
ADD mysqld_charset.cnf /etc/mysql/conf.d/mysqld_charset.cnf
ADD create_spring_batch_user_db.sh /create_spring_batch_user_db.sh
ADD start_mysql.sh /start_mysql.sh

EXPOSE 3306

CMD /start_mysql.sh 
