NGINX_IMAGE_NAME=nginx
NGINX_CONTAINER_NAME=nginx-container

WP_IMAGE_NAME=wordpress
WP_CONTAINER_NAME=wp-container

MARIADB_IMAGE_NAME=mariadb
MARIADB_CONTAINER_NAME=mariadb-containererer

nginx:
	docker build --tag $(NGINX_IMAGE_NAME) ./srcs/requirements/nginx
	docker run --name $(NGINX_CONTAINER_NAME) -d -p 443:443 -p 80:80 $(NGINX_IMAGE_NAME)

wordpress:
	docker build --tag $(WP_IMAGE_NAME) ./srcs/requirements/wordpress
	docker run --name $(WP_CONTAINER_NAME) -d $(WP_IMAGE_NAME)


mariadb:
	docker build --tag $(MARIADB_IMAGE_NAME) ./srcs/requirements/mariadb
	docker run --name $(MARIADB_CONTAINER_NAME) -dp3307:3306 --restart always $(MARIADB_IMAGE_NAME)
