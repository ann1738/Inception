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
	if [[ $(wp user get 2 --field=login --allow-root | grep $NORMAL_USER) -ne 0 ]]; then
		wp user create --allow-root $NORMAL_USER $NORMAL_EMAIL --user_pass=$NORMAL_PASS
	fi

#	Change the theme
	wp theme  activate twentytwentytwo --allow-root

#	Bonus
	if [[ $1 -eq "bonus" ]]; then
#		Redis install and configuration
		if [[ $(wp plugin is-installed redis-cache --allow-root) -ne 0 ]]; then
			wp config set WP_REDIS_PATH --raw "__DIR__ . '/../redis.sock'" --allow-root
			wp config set WP_REDIS_SCHEME "unix" --allow-root
			wp plugin install redis-cache --activate --allow-root
		fi
	fi

#	Update all plugins
	wp plugin update --all --allow-root
