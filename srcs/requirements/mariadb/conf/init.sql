-- srcs/requirements/mariadb/conf/init.sql
DELETE FROM mysql.user WHERE USER='';
DROP DATABASE IF EXISTS test;
DELETE FROM mysql.db WHERE Db='test' OR Db='test\\_%';
FLUSH PRIVILEGES;

CREATE DATABASE IF NOT EXISTS ${MYSQL_DATABASE};
CREATE USER IF NOT EXISTS '${MYSQL_USER}'@'%' IDENTIFIED BY '${MYSQL_PASSWORD}';
GRANT ALL PRIVILEGES ON ${MYSQL_DATABASE}.* TO '${MYSQL_USER}'@'%';
FLUSH PRIVILEGES;
--
--
--
--
--
-- CREATE TABLE IF NOT EXISTS wp_options (
--   option_id bigint(20) unsigned NOT NULL AUTO_INCREMENT,
--   option_name varchar(191) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '',
--   option_value longtext COLLATE utf8mb4_unicode_ci NOT NULL,
--   autoload varchar(20) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT 'yes',
--   PRIMARY KEY (option_id),
--   UNIQUE KEY option_name (option_name)
-- ) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
