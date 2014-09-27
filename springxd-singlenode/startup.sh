#!/bin/bash

XD_HOME=/opt/springxd/xd
XD_LOGS=${XD_HOME}/logs
LOGFILE=${XD_LOGS}/singlenode-console.log

mkdir -p ${XD_LOGS}

echo -e "Starting Spring XD Singlenode\n\n"

nohup $XD_HOME/bin/xd-singlenode 2>1 > $LOGFILE &

while [ ! -f $LOGFILE ] 
do sleep 1; done

while ! grep "Container arrived" $LOGFILE
do 
  echo -n "."
  sleep 1
done

echo -e "Spring XD Single node started.\n\n"
echo -e "Logs are available at : $LOGFILE\n"

echo -e "Starting Spring XD Shell\n"

$XD_HOME/../shell/bin/xd-shell

