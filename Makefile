DOCKER_COMPOSE_FILE_PATH = ./srcs/docker-compose.yml
NGINX_CONTAINER_DEFAULT_NAME = srcs-nginx-1
WORDPRESS_CONTAINER_DEFAULT_NAME = srcs-worpress-1
MARIADB_CONTAINER_DEFAULT_NAME = srcs-mariadb-1

all: start

#Operation rules
start: add_domain
	docker compose --file ${DOCKER_COMPOSE_FILE_PATH} up  --detach

start_verbose: add_domain
	docker compose --file ${DOCKER_COMPOSE_FILE_PATH} up

build:
	docker compose --file ${DOCKER_COMPOSE_FILE_PATH} build

end:
	docker compose --file ${DOCKER_COMPOSE_FILE_PATH} down

clear_all: containers_rm volumes_rm networks_rm

re: clear_all start_verbose

#Utility rules
add_domain:
	@bash ./srcs/requirements/tools/addDomain.sh

networks_rm:
	@bash ./srcs/requirements/tools/removeNetworks.sh || exit 0

volumes_rm:
	@bash ./srcs/requirements/tools/removeVolumes.sh || exit 0

containers_rm:
	@bash ./srcs/requirements/tools/removeContainers.sh || exit 0

#Container access rules
nginx-exec:
	docker exec -it ${NGINX_CONTAINER_DEFAULT_NAME} bash

wordpress-exec:
	docker exec -it ${WORDPRESS_CONTAINER_DEFAULT_NAME} bash

mariadb-exec:
	docker exec -it ${MARIADB_CONTAINER_DEFAULT_NAME} bash
