#!/bin/bash
ls /var/www/html/static &> /dev/null
if [[ $? != 0 ]]; then
	mv static /var/www/html/static
fi

nginx -g "daemon off;"
