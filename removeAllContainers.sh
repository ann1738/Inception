#!/bin/bash
# docker ps -aq 2>/dev/null
# if [[ $? != 0 ]]; then
# 	echo "No containers found!"
# 	exit
# fi

docker rm -f $(docker ps -aq)