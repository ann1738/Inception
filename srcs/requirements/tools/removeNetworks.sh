#!/bin/bash
FRONTEND_NETWORK="srcs_duck"
BACKEND_NETWORK="srcs_turtle"

docker network ls | grep $FRONTEND_NETWORK &> /dev/null
if [[ $? -eq 0 ]]; then
	docker network rm $FRONTEND_NETWORK &> /dev/null
	echo "Removed network '$FRONTEND_NETWORK'"
fi

docker network ls | grep $BACKEND_NETWORK &> /dev/null
if [[ $? -eq 0 ]]; then
	docker network rm $BACKEND_NETWORK &> /dev/null
	echo "Removed network '$BACKEND_NETWORK'"
fi