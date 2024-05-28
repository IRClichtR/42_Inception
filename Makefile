all:
	@docker compose -f ./srcs/docker-compose.yml up -d --build


down:
	@docker compose -f ./srcs/docker-compose.yml down


rm_volume: down
	@docker volume rm srcs_wordpress
	@docker volume rm srcs_mariadb


rm_image: down
	@docker image rm nginx:42 -f
	@docker image rm wordpress:42 -f
	@docker image rm mariadb:42 -f


clean: down rm_volume rm_image
	@docker builder prune -f
	@docker system prune -a
	@docker volume prune -f
	@sudo rm -rf ./srcs/requirements/mariadb/data/*
	@sudo rm -rf ./srcs/requirements/wordpress/web/*


re: clean all

ps: 
	@docker compose -f ./srcs/docker-compose.yml ps

.PHONY: all re down clean





#docker stack deploy -c docker-compose.yml my-nginx-stack

#docker-compose up -d -->
# The -d option in Docker commands, such as docker-compose up -d, stands for "detached mode." When you run a Docker command with this option, Docker will start the containers in the background and not attach the console to the container's standard input, output, and standard error. This means that the command will return immediately, and you won't see the output of the container in your terminal.