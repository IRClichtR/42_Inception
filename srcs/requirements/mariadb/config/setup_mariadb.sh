#!/bin/bash

# Ensure the environment variables are set
if [ -z "$db_name" ] || [ -z "$db_user" ] || [ -z "$db_pwd" ] || [ -z "$MYSQL_ROOT_PASSWORD" ]; then
    echo "Environment variables db_name, db_user, and db_pwd must be set."
    exit 1
fi

# Log the environment variables for debugging purposes
echo "Database Name: $db_name"
echo "Database User: $db_user"
echo "Database Password: $db_pwd"
echo "Database Root PWD: $MYSQL_ROOT_PASSWORD"

mkdir -p /run/mysqld
chown -R mysql:mysql /run/mysqld /var/lib/mysql

mysqld_safe --datadir='/var/lib/mysql' &
sleep 10

echo "Hey ! just trying to launch mysql"


echo "CREATE DATABASE IF NOT EXISTS \`$db_name\` ;" > mydb.sql
echo "CREATE USER IF NOT EXISTS '$db_user'@'%' IDENTIFIED BY '$db_pwd' ;" >> mydb.sql
echo "GRANT ALL PRIVILEGES ON \`$db_name\`.* TO '$db_user'@'%' ;" >> mydb.sql
echo "ALTER USER 'root'@'localhost' IDENTIFIED BY '$MYSQL_ROOT_PASSWORD' ;" >> mydb.sql
echo "FLUSH PRIVILEGES;" >> mydb.sql

# Execute SQL file
mysql -u root -p"$MYSQL_ROOT_PASSWORD" < mydb.sql
if [ $? -ne 0 ]; then
    echo "Error: Unable to execute SQL commands."
    exit 1
fi

# Clean up
rm mydb.sql

# Stop MySQL safely
mysqladmin -u root -p"$MYSQL_ROOT_PASSWORD" shutdown


#mysql < mydb.sql

kill $(cat /var/run/mysqld/mysqld.pid)

mysqld
