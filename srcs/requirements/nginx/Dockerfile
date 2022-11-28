#NIGNX DOCKERFILE
FROM debian:buster

# EXPOSE 80/tcp

ENV DEBIAN_FRONTEND=noninteractive

RUN apt-get -y update 			&& \
	# apt-get -y upgrade 			&& \
	apt-get install -y	nginx  	\
						openssl \
						dialog
# COPY conf/ etc/nginx/
COPY conf/nginx.conf /etc/nginx/
COPY tools/generateSSL.sh /etc/nginx/
COPY conf/csrDetails.conf /etc/nginx/

RUN  bash /etc/nginx/generateSSL.sh

ENV DEBIAN_FRONTEND=dialog

#[BONUS] to serve the static webpage
# RUN mkdir -p /var/www/html/static
COPY static-bonus /
COPY tools/init.sh / 

CMD ["bash", "init.sh"]
