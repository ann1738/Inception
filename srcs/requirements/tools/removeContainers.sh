#!/bin/bash

docker ps -aq &>/dev/null
if [[ $? -eq 0 ]]; then
	docker rm -f $(docker ps -aq) &>/dev/null
	echo "Removed available containers"
fi
