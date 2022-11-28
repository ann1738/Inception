ls /var/www/html/static &> /dev/null
if [[ $? != 0 ]]; then
	# mkdir -p /var/www/html/static
	mv static /var/www/html/static
fi

nginx -g "daemon off;"
