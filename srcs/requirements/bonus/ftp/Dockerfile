# FTP DOCKERFILE
FROM debian:buster

ENV DEBIAN_FRONTEND=noninteractive

ARG FTP_USER
ARG FTP_PASS

RUN apt-get -y update &&\
	apt-get -y install	vsftpd \
						dialog

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
	mkdir -p /var/run/vsftpd/empty && \
#	Include the ftp user in the list of allowed ftp users
	echo ${FTP_USER} > /etc/vsftpd.userlist

ENV DEBIAN_FRONTEND=dialog

COPY /conf/vsftpd.conf /etc/
