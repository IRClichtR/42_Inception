#!/bin/bash
# srcs/requirements/mariadb/conf/docker-entrypoint.sh

set -e

# Create and own MySQL directories
mkdir -p /run/mysqld /var/lib/mysql
chown -R mysql:mysql /run/mysqld /var/lib/mysql

echo $MY

# Initialize the database if it hasn't been initialized
if [ ! -d "/var/lib/mysql/mysql" ]; then
    echo 'Initializing database...'
    mysql_install_db --user=mysql --datadir=/var/lib/mysql --auth-root-authentication-method=socket

    # Start MySQL in the background
    mysqld_safe --datadir="/var/lib/mysql" &
    pid="$!"

    # Wait for MySQL to start up
    until mysqladmin ping --silent; do
        echo 'Waiting for mysqld to be connectable...'
        sleep 2
    done

    # Replace environment variables in init.sql
    envsubst < /docker-entrypoint-initdb.d/init.sql > /tmp/init.sql

    # Execute initialization script
    echo 'Running init.sql...'
    mysql -u root < /tmp/init.sql

    # Stop MySQL process
    mysqladmin shutdown

    # Wait for the MySQL process to exit
    wait "$pid"
fi

# Start MySQL server properly
exec mysqld_safe --datadir="/var/lib/mysql"
