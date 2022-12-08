# NGINX DOCKERFILE
FROM debian:buster

ENV DEBIAN_FRONTEND=noninteractive

RUN apt-get -y update 			&& \
	apt-get install -y	nginx  	\
						openssl \
						dialog

# Nginx configuration
COPY conf/nginx.conf /etc/nginx/
# Self-signed ceritificate configuration
COPY conf/csrDetails.conf /etc/nginx/
# SSL generation script
COPY tools/generateSSL.sh /etc/nginx/
# Initialization script
COPY tools/init.sh / 
# [BONUS] Static webpage
COPY static-bonus /

RUN bash /etc/nginx/generateSSL.sh

ENV DEBIAN_FRONTEND=dialog
