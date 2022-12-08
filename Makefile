#Welcome to my Makefile

#Variables
DOCKER_COMPOSE_FILE_PATH = ./srcs/docker-compose.yml

NGINX_CONTAINER_DEFAULT_NAME = srcs-nginx-1
WORDPRESS_CONTAINER_DEFAULT_NAME = srcs-wordpress-1
MARIADB_CONTAINER_DEFAULT_NAME = srcs-mariadb-1

ADD_DOMAIN_SCRIPT_PATH = ./srcs/requirements/tools/addDomain.sh
REMOVE_CONTAINERS_SCRIPT_PATH = ./srcs/requirements/tools/removeContainers.sh
REMOVE_NETWORKS_SCRIPT_PATH = ./srcs/requirements/tools/removeNetworks.sh
REMOVE_VOLUMES_SCRIPT_PATH = ./srcs/requirements/tools/removeVolumes.sh
CUSTOM_ALIASES_SCRIPT_PATH = ./srcs/requirements/tools/customAliases.sh

WWW_VOLUME_PATH = /home/${USER}/data/www_volume
DB_VOLUME_PATH = /home/${USER}/data/db_volume

#Bonus variables
BONUS_DOCKER_COMPOSE_FILE_PATH = ./srcs/requirements/bonus/docker-compose-bonus.yml

BONUS_NGINX_CONTAINER_DEFAULT_NAME = bonus-nginx-1
BONUS_WORDPRESS_CONTAINER_DEFAULT_NAME = bonus-wordpress-1
BONUS_MARIADB_CONTAINER_DEFAULT_NAME = bonus-mariadb-1
BONUS_FTP_CONTAINER_DEFAULT_NAME = bonus-ftp-1
BONUS_REDIS_CONTAINER_DEFAULT_NAME = bonus-redis-1
BONUS_DEV_CONTAINER_DEFAULT_NAME = bonus-dev-1
BONUS_REDIS_COMMANDER_CONTAINER_DEFAULT_NAME = bonus-redis-commander-1

all: start

#Operation rules
start: add_domain create_volume_directories
	docker compose --file ${DOCKER_COMPOSE_FILE_PATH} up  --detach

start_verbose: add_domain create_volume_directories
	docker compose --file ${DOCKER_COMPOSE_FILE_PATH} up

build:
	docker compose --file ${DOCKER_COMPOSE_FILE_PATH} build

end:
	docker compose --file ${DOCKER_COMPOSE_FILE_PATH} down

up: start_verbose

down: end

clear_all: containers_rm volumes_rm networks_rm remove_volume_directories

re: end clear_all start_verbose

res: end clear_all build start_verbose

create_volume_directories: create_www_vol_directory create_db_vol_directory

remove_volume_directories: remove_www_vol_directory remove_db_vol_directory

create_www_vol_directory:
	@mkdir -p ${WWW_VOLUME_PATH}

remove_www_vol_directory:
	sudo rm -rf ${WWW_VOLUME_PATH}

create_db_vol_directory:
	@mkdir -p ${DB_VOLUME_PATH}

remove_db_vol_directory:
	sudo rm -rf ${DB_VOLUME_PATH}

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

#Custom rules
aliases:
	@bash ./srcs/requirements/tools/customAliases.sh

#Bonus rules
start_bonus: add_domain create_volume_directories
	docker compose --file ${BONUS_DOCKER_COMPOSE_FILE_PATH} up  --detach

start_verbose_bonus: add_domain create_volume_directories
	docker compose --file ${BONUS_DOCKER_COMPOSE_FILE_PATH} up

build_bonus:
	docker compose --file ${BONUS_DOCKER_COMPOSE_FILE_PATH} build

end_bonus:
	docker compose --file ${BONUS_DOCKER_COMPOSE_FILE_PATH} down

up_bonus: start_verbose_bonus

down_bonus: end_bonus

re_bonus: end_bonus clear_all start_verbose_bonus

res_bonus: end_bonus clear_all build_bonus start_verbose_bonus

#Bonus container access rules
nginx-exec-bonus:
	docker exec -it ${BONUS_NGINX_CONTAINER_DEFAULT_NAME} bash

wordpress-exec-bonus:
	docker exec -it ${BONUS_WORDPRESS_CONTAINER_DEFAULT_NAME} bash

mariadb-exec-bonus:
	docker exec -it ${BONUS_MARIADB_CONTAINER_DEFAULT_NAME} bash

ftp-exec-bonus:
	docker exec -it ${BONUS_FTP_CONTAINER_DEFAULT_NAME} bash

redis-exec-bonus:
	docker exec -it ${BONUS_REDIS_CONTAINER_DEFAULT_NAME} bash

dev-exec-bonus:
	docker exec -it ${BONUS_DEV_CONTAINER_DEFAULT_NAME} bash

redis-commander-exec-bonus:
	docker exec -it ${BONUS_REDIS_COMMANDER_CONTAINER_DEFAULT_NAME} bash

#Bonus miscellaneous rules
watch-mysql-queries:
	docker exec -it ${BONUS_MARIADB_CONTAINER_DEFAULT_NAME} mysqladmin -uwp-db-user -p -hmariadb -i 1 processlist;

get-ftp-container-ip:
	@docker inspect -f '{{range.NetworkSettings.Networks}}{{.IPAddress}}{{end}}' ${BONUS_FTP_CONTAINER_DEFAULT_NAME}

open-redis-commander:
	xdg-open "http://anasr.42.fr:8081"

open-ftp-client: get-ftp-container-ip
	filezilla