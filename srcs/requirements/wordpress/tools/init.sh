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
		# chown -R www-data /var/www/html/wp-content/uploads
		chown www-data:www-data  -R * # Let Apache be owner
		find . -type d -exec chmod 755 {} \;  # Change directory permissions rwxr-xr-x
		find . -type f -exec chmod 644 {} \;  # Change file permissions rw-r--r--

	fi

#	Create another user with a default subscriber role
	if [[ $(wp user list --allow-root | grep $NORMAL_USER) != 0 ]]; then
		wp user create --allow-root $NORMAL_USER $NORMAL_EMAIL --user_pass=$NORMAL_PASS
	fi

#	Change the theme (after checking if it was active)
	wp theme is-active twentytwentytwo --allow-root || wp theme activate twentytwentytwo --allow-root

#	Bonus
	if [[ $1 == "bonus" ]]; then
		# Redis install and configuration
		if [[ $(wp plugin is-installed redis-cache --allow-root) != 0 ]]; then
			wp config set WP_REDIS_HOST --raw "'redis'" --allow-root
			wp config set WP_REDIS_PORT --raw "'6379'" --allow-root
			# wp config set WP_REDIS_SCHEME --raw "'unix'" --allow-root
			wp config set WP_CACHE_KEY_SALT --raw "'anasr.42.fr'" --allow-root
			wp config set FS_METHOD --raw "'direct'" --allow-root
			wp plugin install redis-cache --allow-root
			# maybe wee need to install phpredis
		fi
		if [[ $(wp plugin is-active redis-cache --allow-root) != 0 ]]; then
			wp plugin activate redis-cache --allow-root
			wp redis enable --allow-root
		fi
#		Move adminer.php to the root of website files
		mkdir -p /var/www/html/adminer
		if [[ $(ls /var/www/html/adminer/ | grep adminer.php) != 0 ]]; then
			mv /usr/share/adminer/adminer.php /var/www/html/adminer/
		fi
		# Making the directory group writeable such that ftp user (in the same grop) can change files
		chmod -R g+w /var/www/html
	fi
	chown -R www-data:www-data /var/www/html

#	Update all plugins
	wp plugin update --all --allow-root
