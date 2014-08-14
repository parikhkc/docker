#!/bin/bash

DB_HOME="/var/lib/mysql"

if [[ ! -d $DB_HOME/mysql ]]; then
    echo "Initilizing MySQL DB."
    mysql_install_db > /dev/null 2>&1
    echo "Done initializing MySQL DB."  
    /create_spring_batch_user_db.sh
fi

echo "Starting MySQL DB."
/usr/bin/mysqld_safe > /dev/null 2>&1 &

timeout=60
while ! mysqladmin -uroot ping >/dev/null 2>&1
do
        timeout=$(expr $timeout - 1)
        if [ $timeout -eq 0 ]; then
                echo "Timeout starting MySQL."
                exit 1
        fi
        sleep 1
done

