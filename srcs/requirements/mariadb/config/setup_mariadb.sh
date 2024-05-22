#!/bin/bash


export DB_NAME=${DB_NAME}
export DB_USER=${DB_USER}
export PASS=${PASS}

if [ ! -d "/var/lib/mysql/mysql" ]; then
	mariadb-install-db --user=mysql --basedir=/usr --datadir=/var/lib/mysql
fi

mysqld_safe --datadir='/var/lib/mysql' &

# Wait for the MariaDB server to start
sleep 10

# Create the database and user if they do not already exist
mysql -uroot <<-EOSQL
    CREATE DATABASE IF NOT EXISTS ${DB_NAME};
    CREATE USER IF NOT EXISTS '${DB_USER}'@'%' IDENTIFIED BY '${PASS}';
    GRANT ALL PRIVILEGES ON ${DB_NAME}.* TO '${DB_USER}'@'%';
    FLUSH PRIVILEGES;
EOSQL

mysqld
