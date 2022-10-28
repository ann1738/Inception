#Base Image
FROM debian:buster

#
EXPOSE 80/tcp

#
RUN apt-get -y update && apt-get upgrade -y --no-install-recommends \
	&& apt-get install -y nginx && apt-get install -y nano

COPY ./default etc/nginx/sites-available/default
COPY .	/nginx.conf etc/nginx/nginx.conf

#
CMD ["nginx", "-g", "daemon off;"]
