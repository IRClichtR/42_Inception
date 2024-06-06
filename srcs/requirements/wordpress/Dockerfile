FROM debian:11

# Avoid prompts from apt
ENV DEBIAN_FRONTEND=noninteractive

# Installer les paquets nécessaires pour ajouter un dépôt tiers
RUN apt-get update && \
    apt-get install -y \
    lsb-release \
    apt-transport-https \
    ca-certificates \
    curl \
    wget \
    unzip \
    less \
    mariadb-client \
    gnupg2

# Ajouter le dépôt pour PHP 7.4
RUN echo "deb https://packages.sury.org/php/ $(lsb_release -sc) main" | tee /etc/apt/sources.list.d/sury-php.list && \
    curl -fsSL https://packages.sury.org/php/apt.gpg | gpg --dearmor -o /etc/apt/trusted.gpg.d/sury-php.gpg

# Installer PHP 7.4 et les extensions nécessaires
RUN apt-get update && \
    apt-get install -y \
    php7.4 \
    php7.4-fpm \
    php7.4-mysql \
    php7.4-curl \
    php7.4-gd \
    php7.4-mbstring \
    php7.4-xml \
    php7.4-xmlrpc \
    php7.4-soap \
    php7.4-intl \
    php7.4-zip

# Make sure /usr/local/bin in on the path
# ENV PATH="/usr/local/bin:${PATH}"

# Download and install wp-cli
RUN curl -O https://raw.githubusercontent.com/wp-cli/builds/gh-pages/phar/wp-cli.phar && \
    chmod +x wp-cli.phar && \
    mv wp-cli.phar /usr/local/bin/wp-cli.phar


# Ensure the /var/www/html directory exists
RUN mkdir -p /var/www/html

# Download, extract WordPress, move files, and set permissions
RUN wget https://wordpress.org/latest.tar.gz
RUN tar -xzvf latest.tar.gz
RUN mv wordpress/* /var/www/html/
RUN chown -R root:root /var/www/html \
    && rm -rf latest.tar.gz wordpress


COPY ./conf/docker-entrypoint.sh /usr/local/bin/
COPY ./conf/www.conf /etc/php/7.4/fpm/pool.d/www.conf
RUN chmod +x /usr/local/bin/docker-entrypoint.sh

# open Wordpress port to allow communication into docker network
EXPOSE 9000

# Set entrypoint
ENTRYPOINT ["/usr/local/bin/docker-entrypoint.sh"]

CMD ["/usr/sbin/php7.4-fpm", "-F"]
