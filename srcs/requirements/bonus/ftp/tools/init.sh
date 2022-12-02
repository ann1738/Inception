#	Make a symbolic link to allow the user to change the wordpress website volume
# if [[ $(ls| grep wp-data) != 0 ]]; then
	# ln -s /var/www/html /home/${FTP_USER}/wp-data
# 	Change ownership and permissions of website volume directory to allow user to access it
	# chown nobody:nogroup /var/www/html
	# chmod 300 /var/www/html
# fi

usermod -aG root ${FTP_USER}
usermod -g root ${FTP_USER}
chown -R ${FTP_USER}:root /var/www/html
#check what will happen to the upload access because another user should have that
chmod g+s /var/www/html/
echo "Ftp Initialization Done!"

# vi /etc/vsftpd.conf
# Add the line 'user_config_dir=/etc/vsftpd_user_conf' (no quotes)
# mkdir /etc/vsftpd_user_conf;
# cd /etc/vsftpd_user_conf
# vi user_name;
# Enter the line 'local_root=/srv/ftp/user_name'