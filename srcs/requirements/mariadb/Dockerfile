#MARIADB DOCKERFILE
FROM debian:buster

ENV DEBIAN_FRONTEND=noninteractive

RUN apt-get -y update \
	&& apt-get install -y	mariadb-server \
							ca-certificates \
							dialog

#To configure the server to connect with the wordpress container
COPY ./conf/50-server.cnf /etc/mysql/mariadb.conf.d/
COPY ./conf/init.sql /

# RUN "service mysql start && mysql -uroot -ppassword < init.sql"

ENV DEBIAN_FRONTEND=dialog


# ENTRYPOINT ["service mysql start"]
# ENTRYPOINT ["tail -f /dev/null"]
# CMD ["service mysql start && mysqld"]
#mysqld --socket=wordpress --port=3306
# ENTRYPOINT ["service mysql start && tail -f /dev/null"]
