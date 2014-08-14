#!/bin/bash

XD_HOME=/spring-xd-1.0.0.RELEASE/xd
XD_LOGS=${XD_HOME}/logs
LOGFILE=${XD_LOGS}/singlenode-console.log

mkdir -p ${XD_LOGS}

# Start Spring XD Singlenode
echo "Starting Spring XD Singlenode"
#exec $XD_HOME/bin/xd-singlenode >> $LOGFILE 2>&1 & echo \${!}
#RETVAL=$?
#case "$RETVAL" in
#    0)
#        echo "Spring XD Singlenode started."
#        echo "Log file: ${LOGFILE}"
#        ;;
#    1)
#        echo "Spring XD Singlenode start failed"
#        exit 1
#        ;;
#esac
$XD_HOME/bin/xd-singlenode
