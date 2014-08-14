#!/bin/bash

if [ ! -f /.rabbitmq_password_set ]; then
    echo "Setting RabbitMQ default username and password"
    USER=${spring_rabbitmq_username:-"admin"}
    PASS=${spring_rabbitmq_password:-"admin"}
    cat > /etc/rabbitmq/rabbitmq.config <<EOF
[
	{rabbit, [{default_user, <<"$USER">>},{default_pass, <<"$PASS">>},{tcp_listeners, [{"0.0.0.0", 5672}]}]}
].
EOF
fi

touch /.rabbitmq_password_set

echo "Starting RabbitMQ Server"
/usr/sbin/rabbitmq-server
