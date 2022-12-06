FROM debian:buster

ENV DEBIAN_FRONTEND=noninteractive

ARG FTP_USER
ARG FTP_PASS
# make sure to remove the chmod 777 thing
RUN apt-get -y update &&\
	apt-get -y install	vsftpd \
						dialog
RUN apt-get -y install nano net-tools
RUN \
#	Add secure user
	useradd --system --no-user-group --shell /usr/sbin/nologin ftpsecure && \
#	Add ftp user
	useradd --create-home --shell /bin/bash ${FTP_USER} && \
#	Change ftp user password
	echo "${FTP_PASS}\n${FTP_PASS}" > chPass.txt && \
	passwd jelly < chPass.txt && \
	rm -f chPass.txt && \
#	Add ftp user to the www-data group as a primary group
	usermod -g www-data ${FTP_USER} && \
#
	mkdir -p /var/run/vsftpd/empty && \
#	Include the ftp user in the user list of allowed ftp users
	echo ${FTP_USER} > /etc/vsftpd.userlist




#	Change vsftpd.conf to allow to write in user's directories and PAM module
	# sed -i "s/pam_service_name=vsftpd/pam_service_name=ftp/g" /etc/vsftpd.conf && \
	# sed -i "s/#write_enable=YES/write_enable=YES/g" /etc/vsftpd.conf && \
	# sed -i "s/#local_umask=022/local_umask=022/g" /etc/vsftpd.conf && \
	# sed -i "s/#nopriv_user=ftpsecure/nopriv_user=ftpsecure/g" /etc/vsftpd.conf && \
	# sed -i "s/#chroot_local_user=YES/chroot_local_user=YES/g" /etc/vsftpd.conf && \

#	Change the default root of ftp user to wevsite root folder, namely /var/www/html
	# echo "local_root=/var/www/html" >> /etc/vsftpd.conf && \
	# echo "user_sub_token=$FTP_USER" >> /etc/vsftpd.conf && \
	# echo "userlist_enable=YES" >> /etc/vsftpd.conf && \
	# echo "userlist_file=/etc/vsftp.user_list" >> /etc/vsftpd.conf && \
	# echo "userlist_deny=NO" >> /etc/vsftpd.conf && \
	# echo "pasv_enable=Yes" >> /etc/vsftpd.conf && \
	# echo "pasv_min_port=42000" >> /etc/vsftpd.conf && \
	# echo "pasv_min_port=48000" >> /etc/vsftpd.conf && \
	# echo "pasv_address=0.0.0.0" >> /etc/vsftpd.conf && \










# RUN echo "local_umask=022" >> /etc/vsftpd.conf && \

# chroot_local_user=YES
# ftpd_banner=Welcome to blah FTP service.
# nopriv_user=ftpsecure
# local_umask=022


ENV DEBIAN_FRONTEND=dialog

COPY /tools/init.sh /
COPY /conf/vsftpd.conf /etc/
# local_umask 0277
# file_open_mode 0677

# 		Three steps:
# ftp secure login
# ftp user
# add group

#config
# allow_writabe
# passive port
# passive module

# ftp_secure, change_root_local yes, userlis_ --- ftpusersecure
# system -- no create -group, --disable login
# local_umask=022
# noprivuse=ftp_secure
# DONT change file_open