#!/bin/bash
FRONTEND_VOLUME="srcs_www-duck-data"
BACKEND_VOLUME="srcs_db-duck-data"

docker volume ls | grep $FRONTEND_VOLUME &> /dev/null
if [[ $? -eq 0 ]]; then
	docker volume rm -f $FRONTEND_VOLUME &> /dev/null
	echo "Removed volume '$FRONTEND_VOLUME'"
fi

docker volume ls | grep $BACKEND_VOLUME &> /dev/null
if [[ $? -eq 0 ]]; then
	docker volume rm -f $BACKEND_VOLUME &> /dev/null
	echo "Removed volume '$BACKEND_VOLUME'"
fi