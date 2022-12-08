# REDIS-COMMANDER DOCKERFILE
FROM debian:buster

ENV DEBIAN_FRONTEND=noninteractive

RUN apt-get update -y && \
	apt-get install -y dialog \
					   ca-certificates \
					   npm \
					   nodejs \
					   curl \
					   wget

RUN \
#	Install redis-commander
	npm install -g redis-commander && \
#	Install newer nodejs version
	npm install -g n && \
	n lts

ENV DEBIAN_FRONTEND=dialog
