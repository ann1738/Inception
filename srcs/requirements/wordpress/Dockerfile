# WORDPRESS DOCKERFILE
FROM debian:buster

ARG BONUS

ENV DEBIAN_FRONTEND=noninteractive

RUN apt-get -y	update && \
	apt-get -y  install	software-properties-common && \
	add-apt-repository ppa:ondrej/php			&& \
	apt-get -y  install	php7.3-fpm 			\
						wget				\
						ca-certificates		\
						dialog			\
						mariadb-client \
						php-mysqli \
						curl

WORKDIR /var/www/html

RUN	wget http://wordpress.org/latest.tar.gz && \
	tar xfz latest.tar.gz && \
	mv wordpress/* ./ && \
	rm -f latest.tar.gz && \
	rm -f index.html && \
#	Install wp-cli
	curl -O https://raw.githubusercontent.com/wp-cli/builds/gh-pages/phar/wp-cli.phar && \
	php wp-cli.phar --info && \
	chmod +x wp-cli.phar && \
	mv wp-cli.phar /usr/local/bin/wp && \
	service php7.3-fpm start    

RUN /bin/bash -c 'if [[ "${BONUS}" == "one" ]] ; then apt-get install -y adminer; fi' &&\
	apt-get autoremove &&\
	apt-get autoclean &&\
	apt-get clean

ENV DEBIAN_FRONTEND=noninteractive

WORKDIR /

COPY ./conf/www.conf /etc/php/7.3/fpm/pool.d/
COPY ./conf/php.ini /etc/php/7.3/fpm/
COPY ./tools/init.sh /
