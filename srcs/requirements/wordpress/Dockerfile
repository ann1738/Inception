#WORDPRESS DOCKERFILE
FROM debian:buster

ENV DEBIAN_FRONTEND=noninteractive

RUN apt-get -y	update && \
	# apt-get -y	upgrade				&&	\
	apt-get -y  install	software-properties-common && \
	add-apt-repository ppa:ondrej/php			&& \
	apt-get -y  install	php7.3-fpm 			\
						wget				\
						ca-certificates		\
						dialog			\
						mariadb-client \
						php-mysqli

RUN	groupadd wordpress_user						&& \
	useradd -g wordpress_user wordpress_user

RUN apt-get -y install net-tools nano

ENV DEBIAN_FRONTEND=noninteractive

EXPOSE 9000/tcp


COPY ./www.conf /etc/php/7.3/fpm/pool.d/

# RUN service php7.3-fpm start

# COPY ./wordpress_pool.conf /etc/php/7.3/fpm/pool.d/






# RUN mkdir -p /var/www/html/anasr.42.fr/src		&& \
# 	cd /var/www/html/anasr.42.fr/src			&& \
# 	wget https://wordpress.org/latest.tar.gz	&& \
# 	tar -xvf latest.tar.gz						&& \
# 	# mv wordpress/* ../public_html/				&& \
# 	chown -R www-data:www-data /var/www/html/anasr.42.fr && \
	# #Install WP-CLI
	# wget https://raw.githubusercontent.com/wp-cli/builds/gh-pages/phar/wp-cli.phar && \
	# #Change permissions and move to /bin such that we can use wp as a command 
	# chmod +x wp-cli.phar 				&& \
	# mv wp-cli.phar /usr/local/bin/wp	&& \
	# wp --info
