FROM 	debian:11


############################ Install php with every necessary otions #############################

RUN 	apt-get update && \
	apt-get install -y \
 		php-fpm \
 		php-xml \
		php-curl \
		php-gd \
		php-mbstring \
 		php-zip \
		php-mysql \
		wget \
		curl \
		git \
		unzip && \
		apt-get clean && \
		rm -rf /var/lib/apt/lists/*

################################# Install WP-CLI to use command line management for php ########################

RUN		curl -O https://raw.githubusercontent.com/wp-cli/builds/gh-pages/phar/wp-cli.phar && \
		chmod +x wp-cli.phar && \
		mv wp-cli.phar /usr/local/bin/wp


################################# Use script to install and launch wordpress ############################### 

COPY		setup-wordpress.sh /var/www/html/setup-wordpress.sh
RUN		chmod +x /var/www/html/setup-wordpress.sh
#ENTRYPOINT	["/usr/local/bin/setup-wordpress.sh"]

################################# Set working dir for WordPress ############################### 

WORKDIR 	/var/www/html/
RUN 		chown -R www-data:www-data /var/www/html \
		&& chmod -R 755 /var/www/html/

################################# Run everything ############################### 

CMD 		["/usr/local/bin/setup-wordpress.sh"]
