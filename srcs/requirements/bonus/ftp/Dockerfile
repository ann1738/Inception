FROM debian:buster

ENV DEBIAN_FRONTEND=noninteractive

# make sure to remove the chmod 777 thing
RUN apt-get -y update &&\
	apt-get install -y	vsftpd && \
	useradd --create-home --password 'password' --shell /bin/bash 'jelly' && \
	mkdir -p /home/'jelly'/ftp && \
	chown nobody:nogroup /home/'jelly'/ftp && \
	chmod a-w /home/'jelly'/ftp && \
	mkdir /home/'jelly'/ftp/share && \
	chown 'jelly':'jelly' /home/'jelly'/ftp/share && \
	echo "jelly" >> /etc/vsftpd.userlist && \
	echo "hehehe! This is a test!" > /home/'jelly'/ftp/share/test.txt
	
	# adduser --home=/var/ftp_share dummy_user && \
	# mkdir /var/ftp_share/subfolder && chmod 777 /var/ftp_share/subfolder && \
	# chown nobody:nogroup /var/ftp_share && \
	# chmod a-w /var/ftp_share

# chown root /etc/vsftpd/vsftpd.conf
COPY conf/vsftpd.conf /etc/

RUN apt-get -y install nano net-tools
ENV DEBIAN_FRONTEND=dialog
