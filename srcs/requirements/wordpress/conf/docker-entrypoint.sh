#!/bin/bash
# srcs/requirements/wordpress/conf/docker-entrypoint.sh

set -e

# Check if WordPress is already installed
if ! wp core is-installed --allow-root; then
    echo "Setting up WordPress..."
    # Download WordPress
    wp core download --allow-root
    # Generate wp-config.php
    wp config create --dbname="$WORDPRESS_DB_NAME" --dbuser="$WORDPRESS_DB_USER" --dbpass="$WORDPRESS_DB_PASSWORD" --dbhost="$WORDPRESS_DB_HOST" --allow-root
    # Install WordPress
    wp core install --url="https://$DOMAIN_NAME" --title="WordPress Site" --admin_user="$WP_ADMIN_USER" --admin_password="$WP_ADMIN_PASSWORD" --admin_email="$WP_ADMIN_EMAIL" --skip-email --allow-root
    # Create additional user
    wp user create "$WP_USER" "$WP_USER_EMAIL" --role=author --user_pass="$WP_USER_PASSWORD" --allow-root
fi

echo "Starting PHP-FPM..."
exec "$@"
