# Makefile

# Define paths
SRC_DIR=srcs
DOCKER_COMPOSE_FILE=$(SRC_DIR)/docker-compose.yml

all: up

# Build and start the Docker containers
up:
	@echo "Starting the services..."
	docker compose -f $(DOCKER_COMPOSE_FILE) up --build -d

# Stop the Docker containers
down:
	@echo "Stopping the services..."
	docker compose -f $(DOCKER_COMPOSE_FILE) down

# Clean up the Docker environment
clean: down
	@echo "Cleaning up unused Docker resources..."
	docker system prune -f
	docker builder prune -f
	@echo "Cleaning up docker volumes directories..."
	sudo rm -rf srcs/*_data

# Restart the Docker containers
re: clean all

# Check the status of the Docker containers
status:
	@echo "Checking the status of the services..."
	docker compose -f $(DOCKER_COMPOSE_FILE) ps

# Tail logs from all the Docker containers
logs:
	@echo "Tailing logs..."
	docker compose -f $(DOCKER_COMPOSE_FILE) logs -f

.PHONY: all up down clean re
