FROM debian:buster

ENV DEBIAN_FRONTEND=noninteractive

RUN apt-get update -y && \
	apt-get install -y dialog \
					   ca-certificates \
					   npm \
					   nodejs && \
	npm install -g redis-commander
RUN apt-get install -y curl wget 
RUN npm install -g n && \
	n lts

ENV DEBIAN_FRONTEND=dialog
