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
		wp core install --allow-root --url=anasr --title="$TITLE" --admin_user=$ADMIN_USER --admin_password=$ADMIN_PASS --admin_email=$ADMIN_EMAIL
	fi

#	Create another user with a default subscriber role
	wp user create --allow-root $NORMAL_USER $NORMAL_EMAIL --user_pass=$NORMAL_PASS

#	Update all plugins
	wp plugin update --all --allow-root