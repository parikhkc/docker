#!/bin/bash

source /env

# Start Zookeeper
/opt/zookeeper-3.4.6/bin/zkServer.sh start 

# Create MySQL User/DB and start it
/start_mysql.sh

# Start RabbitMQ
/start_rabbitmq.sh

# Start Redis
redis-server /etc/redis/redis.conf

XD_HOME=/spring-xd-1.0.0.RELEASE/xd
XD_LOGS=${XD_HOME}/logs
ADMIN_LOGFILE=${XD_LOGS}/admin-console.log
CONTAINER_LOGFILE=${XD_LOGS}/container-console.log

mkdir -p ${XD_LOGS}

# Start Spring XD Admin
echo "Starting XD Admin"
exec $XD_HOME/bin/xd-admin >> $ADMIN_LOGFILE 2>&1 & echo \${!}
RETVAL=$?
case "$RETVAL" in
    0)
        echo "Spring XD Admin started."
        ;;
    1)
        echo "Spring XD Admin start failed"
        exit 1
        ;;
esac


# Start Spring XD Container
echo "Starting XD Container"
#exec $XD_HOME/bin/xd-container >> $CONTAINER_LOGFILE 2>&1 & echo \${!}
#RETVAL=$?
#case "$RETVAL" in
#    0)  
#        echo "Spring XD Container started."
#        ;;  
#    1)  
        echo "Spring XD Container start failed"
#        exit 1
#        ;;  
#esac


$XD_HOME/bin/xd-container
