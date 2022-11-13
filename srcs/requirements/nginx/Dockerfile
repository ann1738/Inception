FROM debian:buster

EXPOSE 80/tcp

RUN apt-get -y update 			&& \
	apt-get install -y nginx 	&& \
	apt-get -y install openssl

COPY conf/ etc/nginx/

RUN  bash /etc/nginx/generateSSL.sh

# CMD ["nginx", "-t"]
CMD ["nginx", "-g", "daemon off;"]
