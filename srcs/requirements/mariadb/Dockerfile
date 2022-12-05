#MARIADB DOCKERFILE
FROM debian:buster

ARG MARIADB_DATABASE
ARG MARIADB_USER
ARG MARIADB_PASSWORD
ARG MARIADB_ROOT_PASSWORD

ENV DEBIAN_FRONTEND=noninteractive

RUN apt-get -y update \
	&& apt-get install -y	mariadb-server \
							ca-certificates \
							dialog

#To configure the server to connect with the wordpress container
COPY ./conf/50-server.cnf /etc/mysql/mariadb.conf.d/

RUN service mysql start && \
	mysql -e "CREATE DATABASE IF NOT EXISTS ${MARIADB_DATABASE}; \
	CREATE USER IF NOT EXISTS '$MARIADB_USER'@'%' IDENTIFIED BY '$MARIADB_PASSWORD'; \
	GRANT ALL PRIVILEGES ON $MARIADB_DATABASE.* TO '$MARIADB_USER'; \
	UPDATE mysql.user SET host='%' WHERE user='root'; \
	ALTER USER 'root'@'%' IDENTIFIED BY '$MARIADB_ROOT_PASSWORD'; \
	FLUSH PRIVILEGES;"

ENV DEBIAN_FRONTEND=dialog
