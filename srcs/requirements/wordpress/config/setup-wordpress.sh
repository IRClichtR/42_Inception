#!/bin/bash

# Put secrets into vars

#DB_NAME=$(cat /run/secrets/db_name)
#DB_USER=$(cat /run/secrets/db_user)
#DB_PASS=$(cat /run/secrets/db_pass)
#<S-F3>DB_HOST=$(cat /run/secrets/db_host)

#WP_SUPERSUSR=$(cat /run/secrets/wp_super_user)
#WP_SUPERSUSR_PASS=$(cat /run/secrets/wp_super_user_pass)
#WP_SUPERSUSR_MAIL=$(cat /run/secrets/wp_super_user_mail)

if [ ! -d "/var/www/html/wordpress" ]; then
	wget https://wordpress.org/latest.tar.gz
	tar -xzf latest.tar.gz -C /var/www/html/
	mv /var/www/html/wordpress/* /var/www/html/
	#rm -rf /var/www/html/wordpress
	rm latest.tar.gz
fi

#chown -R www-data:www-data /var/www/html/

if [ ! -f "/var/www/html/wp-config.php" ]; then
	echo "Hey trying to config create"
	wp config create \
		--dbname="$db_name" \
		--dbuser="$db_user" \
		--dbpass="$db_pwd" \
		--dbhost="$db_host" \
		--allow-root
fi


if ! wp core is-installed --allow-root; then
	echo "Hey trying to core install"
	wp core install \
		--url="$WP_URL" \
		--title="$WP_TITLE" \
		--admin_user="$WP_SUPER_USER" \
		--admin_password="$WP_SUPER_USER_PASS" \
		--admin_email="$WP_SUPER_USER_MAIL" \
		--allow-root
fi

php -S 0.0.0.0:9000 -t /var/www/html/
	
