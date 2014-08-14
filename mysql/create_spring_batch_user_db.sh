#!/bin/bash

/usr/bin/mysqld_safe > /dev/null 2>&1 &

USER=${spring_datasource_username:-"batchuser"}
PASSWORD=${spring_datasource_password:-"password"}
timeout=60
while ! mysqladmin -uroot ping >/dev/null 2>&1
do
	timeout=$(expr $timeout - 1)
	if [ $timeout -eq 0 ]; then
		echo "Timeout starting MySQL (during SpringBatch User and Database creation)."
		exit 1
	fi
	sleep 1
done

mysql -uroot -e "CREATE USER '${USER}'@'%' IDENTIFIED BY '${PASSWORD}'"
mysql -uroot -e "CREATE DATABASE IF NOT EXISTS \`springbatch\` DEFAULT CHARACTER SET 'utf8' COLLATE 'utf8_unicode_ci'"
mysql -uroot -e "GRANT ALL PRIVILEGES ON \`springbatch\`.* TO 'batchuser'@'%'"
mysql -uroot -e "FLUSH PRIVILEGES"

echo "SpringBatch User and Database created!"

mysqladmin -uroot shutdown

