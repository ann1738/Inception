FROM debian:buster


ENV DEBIAN_FRONTEND=noninteractive

RUN apt-get -y update \
	&& apt-get install -y	redis-server \
							nano

ENV DEBIAN_FRONTEND=dialog

EXPOSE 6379

COPY conf/redis.conf /etc/redis/
