#!/bin/bash

FRONTEND_VOLUME="requirements_www-duck-data"
BACKEND_VOLUME="requirements_db-duck-data"

docker volume ls | grep $FRONTEND_VOLUME &> /dev/null
if [[ $? -eq 0 ]]; then
	echo "Removed volume '$FRONTEND_VOLUME'"
	docker volume rm -f $FRONTEND_VOLUME &> /dev/null
fi

docker volume ls | grep $BACKEND_VOLUME &> /dev/null
if [[ $? -eq 0 ]]; then
	echo "Removed volume '$BACKEND_VOLUME'"
	docker volume rm -f $BACKEND_VOLUME &> /dev/null
fi