#!/bin/bash

# start up redis-service
redis-server /etc/redis/redis.conf

# start up sshd service
/usr/sbin/sshd -D
