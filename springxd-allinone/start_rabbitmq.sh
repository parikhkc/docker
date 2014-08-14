#!/bin/bash

if [ ! -f /.rabbitmq_password_set ]; then
    echo "Setting RabbitMQ default username and password"
    PASS=${spring_rabbitmq_password:-"admin"}
    USER=${spring_rabbitmq_username:-"admin"}
    cat > /etc/rabbitmq/rabbitmq.config <<EOF
[
	{rabbit, [{default_user, <<"$USER">>},{default_pass, <<"$PASS">>},{tcp_listeners, [{"0.0.0.0", 5672}]}]}
].
EOF
fi

touch /.rabbitmq_password_set

echo "Starting RabbitMQ Server"
/usr/sbin/rabbitmq-server  > /dev/null 2>&1 &
