# srcs/requirements/mariadb/Dockerfile
FROM debian:bullseye

# Update and Upgrade APT packages
RUN apt update && apt upgrade -y

# Install envbust (environment replacer)
RUN apt install gettext-base -y

# Install MariaDB
RUN apt install mariadb-server -y

# Copy Server configuration
COPY ./conf/50-server.cnf /etc/mysql/mariadb.conf.d/

# Copy initialization script and entrypoint script
COPY ./conf/init.sql /docker-entrypoint-initdb.d/
COPY ./conf/docker-entrypoint.sh /usr/local/bin/
RUN chmod +x /usr/local/bin/docker-entrypoint.sh

# Export MariaDB Port
Expose 3306

# Set the entrypoint
ENTRYPOINT ["docker-entrypoint.sh"]

# Start MariaDB service
CMD ["mysqld"]
