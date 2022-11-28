	#!/bin/bash
	TITLE='THIS IS MY SAMPLE WEBSITE.. sorry capslock was on'

#	Move to the proper work directory	
	cd /var/www/html

#	Creating the php config file if does not exist
	ls | grep "wp-config.php" &> /dev/null
	if [[ $? -ne 0 ]]; then
		wp config create --allow-root --dbname=$WP_DBNAME --dbuser=$WP_DBUSER --dbhost=$WP_DBHOST --dbpass=$WP_DBPASS 
	fi

#	Wordpress installation and creation of the admin user
	wp core is-installed --allow-root
	if [[ $? -ne 0 ]]; then
		wp core install --allow-root --url=anasr.42.fr --title="$TITLE" --admin_user=$ADMIN_USER --admin_password=$ADMIN_PASS --admin_email=$ADMIN_EMAIL
#		Config required to allow media uploads 
		chown -R www-data /var/www/html/wp-content/uploads
	fi

#	Create another user with a default subscriber role
	if [[ $(wp user list --allow-root | grep $NORMAL_USER) != 0 ]]; then
		wp user create --allow-root $NORMAL_USER $NORMAL_EMAIL --user_pass=$NORMAL_PASS
	fi

#	Change the theme
	wp theme  activate twentytwentytwo --allow-root

#	Bonus
	# if [[ $1 == "bonus" ]]; then
#		Redis install and configuration
		# if [[ $(wp plugin is-installed redis-cache --allow-root) != 0 ]]; then
			# wp config set WP_REDIS_PATH --raw "__DIR__ . '/../redis.sock'" --allow-root
			# wp config set WP_REDIS_SCHEME "unix" --allow-root
			# wp plugin install redis-cache --activate --allow-root
		# fi
#		Move adminer.php to the root of website files
		mkdir -p /var/www/html/adminer
		if [[ $(ls /usr/share/adminer/ | grep adminer.php) != 0 ]]; then
			mv /usr/share/adminer/adminer.php /var/www/html/adminer/
		fi
	# fi

#	Update all plugins
	wp plugin update --all --allow-root
