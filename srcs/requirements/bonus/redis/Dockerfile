FROM debian:buster


ENV DEBIAN_FRONTEND=noninteractive

RUN apt-get -y update \
	&& apt-get install -y	lsb-release \
							nano

RUN apt-get install -y curl \
					   wget \
					   gnupg 

RUN curl -fsSL https://packages.redis.io/gpg | gpg --dearmor -o /usr/share/keyrings/redis-archive-keyring.gpg &&\
	echo "deb [signed-by=/usr/share/keyrings/redis-archive-keyring.gpg] https://packages.redis.io/deb $(lsb_release -cs) main" | tee /etc/apt/sources.list.d/redis.list && \
	apt-get update -y && \
	apt-get install -y redis

ENV DEBIAN_FRONTEND=dialog

COPY conf/redis.conf /etc/redis/
