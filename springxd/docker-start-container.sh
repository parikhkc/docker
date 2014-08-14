#!/bin/bash

docker run -t -d --env-file xd.properties kparikh/springxd-distributed:1.0.0 /container
