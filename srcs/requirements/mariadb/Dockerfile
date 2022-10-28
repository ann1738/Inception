FROM debian:buster

ENV MARIADB_ROOT_PASSWORD=myPass

RUN apt-get -y update \
	&& apt-get install -y mariadb-server

LABEL version="1.0"

EXPOSE 3306

CMD ["mysqld"]