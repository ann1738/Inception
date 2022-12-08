#!/bin/bash

echo "Initializing redis"

# Modify redis config file
sed -i "s/bind 127.0.0.1 ::1/#bind 127.0.0.1 ::1/g" /etc/redis/redis.conf
sed -i "s/protected-mode yes/protected-mode no/g" /etc/redis/redis.conf

redis-server --protected-mode no