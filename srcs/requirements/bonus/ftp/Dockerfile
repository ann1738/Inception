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
#	Add ftp user
	useradd --create-home --password ${FTP_PASS} --shell /bin/bash ${FTP_USER} && \
#	Change vsftpd.conf to allow to write in user's directories and PAM module
	sed -i "s/pam_service_name=vsftpd/pam_service_name=ftp/g" /etc/vsftpd.conf && \
	sed -i "s/#write_enable=YES/write_enable=YES/g" /etc/vsftpd.conf && \
	mkdir -p /var/run/vsftpd/empty && \
#	Change the default root of ftp user to wevsite root folder, namely /var/www/html
	echo "local_root=/var/www/html" >> /etc/vsftpd.conf && \
	echo "user_sub_token=$USER" >> /etc/vsftpd.conf && \
#	Change of pass wasn't effective, so this changes the password effectively
	echo "${FTP_PASS}\n${FTP_PASS}" > chPass.txt && \
	passwd jelly < chPass.txt && \
	rm -f chPass.txt && \
#	Include the ftp user in the user list of allowed ftp users
	echo ${FTP_USER} >> /etc/ftpusers

ENV DEBIAN_FRONTEND=dialog

COPY /tools/init.sh /
