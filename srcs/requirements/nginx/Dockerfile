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
COPY conf/generateSSL.sh /etc/nginx/
COPY conf/csrDetails.conf /etc/nginx/

RUN  bash /etc/nginx/generateSSL.sh

ENV DEBIAN_FRONTEND=dialog

# CMD ["nginx", "-t"]
CMD ["nginx", "-g", "daemon off;"]
