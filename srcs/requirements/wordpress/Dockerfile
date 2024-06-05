# Use Debian 11 as the base image
FROM debian:11

# Install necessary packages
RUN apt-get update && apt-get install -y \
    lsb-release \
    apt-transport-https \
    ca-certificates \
    wget \
    curl \
    gnupg \
    && wget -q https://packages.sury.org/php/apt.gpg -O- | apt-key add - \
    && echo "deb https://packages.sury.org/php/ $(lsb_release -sc) main" > /etc/apt/sources.list.d/php.list \
    && apt-get update && apt-get install -y \
    php8.0-fpm \
    php8.0-mysql \
    php8.0-gd \
    php8.0-mbstring \
    php8.0-zip \
    php8.0-exif \
    php8.0-pdo \
    php8.0-pdo-mysql \
    libfreetype6-dev \
    libjpeg62-turbo-dev \
    libpng-dev \
    libzip-dev \
    zip \
    unzip \
    mariadb-client

# Install WordPress CLI
RUN curl -O https://raw.githubusercontent.com/wp-cli/builds/gh-pages/phar/wp-cli.phar \
    && chmod +x wp-cli.phar \
    && mv wp-cli.phar /usr/local/bin/wp

# Set up the working directory
WORKDIR /var/www/html

# Mount the entrypoint script into the docker
COPY ./conf/docker-entrypoint.sh /usr/local/bin/docker-entrypoint.sh
RUN chmod +x /usr/local/bin/docker-entrypoint.sh

# Download and extract WordPress
RUN wp core download --allow-root

# Set the ownership and permissions of the WordPress files
RUN chown -R www-data:www-data /var/www/html \
    && chmod -R 755 /var/www/html

# Expose the port for PHP-FPM
EXPOSE 9000

# Set entrypoint
ENTRYPOINT ["/usr/local/bin/docker-entrypoint.sh"]


# Start PHP-FPM
CMD ["php-fpm"]
