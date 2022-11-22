	#!/bin/bash
	DBNAME=$1
	DBPASS=$2
	DBUSER=$3
	DBHOST=$4

	ADMIN_USER='superPowerRangerr'
	ADMIN_PASS='2KwecuyX#dCS!Ye4or'
	ADMIN_EMAIL='hehe@gmail.com'

	NORMAL_USER='anasrr'
	NORMAL_PASS='blahblah'
	NORMAL_EMAIL='hehe_normal@gmail.com'

	TITLE='The Depressed French Philosopher Jean-Paul Sartre'

#	Move to the proper work directory	
	cd /var/www/html

#	Creating the php config file if does not exist
	ls | grep "wp-config.php" &> /dev/null
	if [[ $? -ne 0 ]]; then
		wp config create --allow-root --dbname=$DBNAME --dbuser=$DBUSER --dbhost=$DBHOST --dbpass=$DBPASS 
	fi

#	Creating the wordpress database if it does not exist
	wp db check --allow-root &> /dev/null
	if [[ $? -ne 0 ]]; then
		wp db create --allow-root
	fi

#	Wordpress installation and creation of the admin user
	wp core install --allow-root --url=anasr --title="$TITLE" --admin_user=$ADMIN_USER --admin_password=$ADMIN_PASS --admin_email=$ADMIN_EMAIL

#	Create another user with a subscriber role
	wp user create --allow-root $NORMAL_USER $NORMAL_EMAIL --user_pass=$NORMAL_PASS
	# --role='Subscriber'

#	Update all plugins
	wp plugin update --all --allow-root
	
	echo "Done initailizing WordPress!"