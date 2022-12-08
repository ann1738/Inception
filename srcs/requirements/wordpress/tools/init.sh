#!/bin/bash
TITLE='THIS IS MY SAMPLE WEBSITE.. sorry capslock was on'

#	Move to the proper work directory
cd /var/www/html

#	Creating the wordpress config file, if does not exist
ls | grep "wp-config.php" &> /dev/null
if [[ $? -ne 0 ]]; then
	wp config create --allow-root --dbname=$WP_DBNAME --dbuser=$WP_DBUSER --dbhost=$WP_DBHOST --dbpass=$WP_DBPASS 
fi

#	Wordpress installation and creation of the admin user
wp core is-installed --allow-root
if [[ $? -ne 0 ]]; then
	wp core install --allow-root --url=anasr.42.fr --title="$TITLE" --admin_user=$ADMIN_USER --admin_password=$ADMIN_PASS --admin_email=$ADMIN_EMAIL
fi

#	Create another user with a default subscriber role
if [[ $(wp user list --allow-root | grep $NORMAL_USER) != 0 ]]; then
	wp user create --allow-root $NORMAL_USER $NORMAL_EMAIL --user_pass=$NORMAL_PASS
fi

#	Activate the twentytwentytwo theme, if it has not been activated
wp theme is-active twentytwentytwo --allow-root || wp theme activate twentytwentytwo --allow-root

#	Bonus
if [[ $1 == "bonus" ]]; then
	# Install redis plugin and configure wordpress accordingly
	if [[ $(wp plugin is-installed redis-cache --allow-root) != 0 ]]; then
		wp config set WP_REDIS_HOST --raw "'redis'" --allow-root
		wp config set WP_REDIS_PORT --raw "'6379'" --allow-root
		wp config set WP_CACHE_KEY_SALT --raw "'anasr.42.fr'" --allow-root
		wp config set FS_METHOD --raw "'direct'" --allow-root
		wp plugin install redis-cache --allow-root
	fi
	# Activate and enable redis plugin
	if [[ $(wp plugin is-active redis-cache --allow-root) != 0 ]]; then
		wp plugin activate redis-cache --allow-root
		wp redis enable --allow-root
	fi
	# Create a directory for adminer and place adminer.php in it
	mkdir -p /var/www/html/adminer
	if [[ $(ls /var/www/html/adminer/ | grep adminer.php) != 0 ]]; then
		mv /usr/share/adminer/adminer.php /var/www/html/adminer/
	fi
	# Make the website's root directory group writeable such that an ftp user (in the same group) can modify files
	chmod -R g+w /var/www/html
fi

#	Change ownership of website's root directory
chown -R www-data:www-data /var/www/html

#	Update all plugins
wp plugin update --all --allow-root
