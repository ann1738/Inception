NGINX_IMAGE_NAME=nginx
NGINX_CONTAINER_NAME=nginx-container

WP_IMAGE_NAME=wordpress
WP_CONTAINER_NAME=wp-container

MARIADB_IMAGE_NAME=mariadb
MARIADB_CONTAINER_NAME=mariadb-container

nginx:
	docker build --tag $(NGINX_IMAGE_NAME) ./srcs/requirements/nginx
	docker run --name $(NGINX_CONTAINER_NAME) -d -p 443:443 -p 80:80 $(NGINX_IMAGE_NAME)

wordpress:
	docker build --tag $(WP_IMAGE_NAME) ./srcs/requirements/wordpress
	docker run --name $(WP_CONTAINER_NAME) -d $(WP_IMAGE_NAME)


mariadb:
	docker build --tag $(MARIADB_IMAGE_NAME) ./srcs/requirements/mariadb
	docker run --name $(MARIADB_CONTAINER_NAME) -d --env="MYSQL_ROOT_PASSWORD=password" -it --entrypoint /bin/bash $(MARIADB_IMAGE_NAME)

volumes_rm:
	@bash ./srcs/requirements/tools/removeVolumes.sh && exit 0

containers_rm:
	@bash ./srcs/requirements/tools/removeContainers.sh && exit 0

nginx-exec:
	docker exec -it requirements-nginx-1 bash
wordpress-exec:
	docker exec -it requirements-wordpress-1 bash
mariadb-exec:
	docker exec -it requirements-mariadb-1 bash
