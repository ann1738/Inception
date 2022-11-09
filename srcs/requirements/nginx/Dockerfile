#Base Image
FROM debian:buster

EXPOSE 80/tcp

RUN apt-get -y update 			&& \
	apt-get install -y nginx 	&& \
	apt-get -y install openssl

# RUN apt-get -y install openssl && bash generateSSL.sh

COPY ./conf/ etc/nginx/

RUN  bash ./etc/nginx/generateSSL.sh

# COPY ./conf/default etc/nginx/sites-available/default
# COPY ./conf/nginx.conf etc/nginx/nginx.conf

#
ENTRYPOINT ["nginx", "-g", "daemon off;"]
