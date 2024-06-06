#!/bin/bash

# Wait for database to launch
# while ! mysqladmin ping -h"$MYSQL_HOSTNAME" --silent; do 
#   echo "Waiting for database connection..."
#   sleep 2
# done



# DOwnload wordpress and put it into /var/www/html directory
if [ ! -f /var/www/html/wp-config.php ]; then
  echo "Downloading WordPress..."
  curl -o /tmp/wordpress.tar.gz https://wordpress.org/latest.tar.gz
  echo "Extracting WordPress..."
  tar -xzf /tmp/wordpress.tar.gz -C /tmp
  echo "Moving WordPress files to /var/www/html..."
  mv /tmp/wordpress/* /var/www/html/
  echo "Setting permissions..."
  chown -R www-data:www-data /var/www/html
  chmod -R 755 /var/www/html
fi

#check if wp-config.php exist
if [ ! -f /var/www/html/wp-config.php ]; then
  /usr/local/bin/wp-cli.phar config create --dbname="$MYSQL_DATABASE" --dbuser="$MYSQL_USER" --dbpass="$MYSQL_PASSWORD" --dbhost="$MYSQL_HOSTNAME" --path=/var/www/html --allow-root
  /usr/local/bin/wp-cli.phar core install --url=http://"$DOMAIN_NAME" --title="Deep Inception" --admin_user="$WP_SURUSER" --admin_password="$WP_SURPHRASE" --admin_email="$WP_SUREMAIL" --path=/var/www/html --skip-email --allow-root
fi 

echo "Starting PHP-FPM..."
exec /usr/sbin/php-fpm7.4 -F
#which php-fpm
#php-fpm -var
