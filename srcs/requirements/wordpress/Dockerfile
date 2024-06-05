# srcs/requirements/wordpress/Dockerfile
FROM debian:bullseye

# Update and Upgrade APT packages
RUN apt update && apt upgrade -y

# Install utilities
#RUN apt install curl -y

# Install PHP and extensions
#RUN apt install php-fpm php-mysql php-cli -y

# Install MySQL client
#RUN apt install mariadb-client -y

# Install WordPress CLI
#RUN curl -O https://raw.githubusercontent.com/wp-cli/builds/gh-pages/phar/wp-cli.phar
#RUN chmod +x wp-cli.phar
#RUN mv wp-cli.phar /usr/local/bin/wp

# Create WordPress directory
#RUN mkdir -p /var/www/html
#WORKDIR /var/www/html

# Copy entrypoint script
#COPY ./conf/docker-entrypoint.sh /usr/local/bin/
#RUN chmod +x /usr/local/bin/docker-entrypoint.sh

# Set the entrypoint
#ENTRYPOINT ["docker-entrypoint.sh"]

# Start PHP-FPM
#CMD ["php-fpm7.4"]
CMD ["ls"]
