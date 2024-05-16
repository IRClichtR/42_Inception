FROM	debian:11

RUN	apt-get update && \
	apt-get install -y mariadb-server && \ 
	apt-get clean && \
	rm -rf /var/lib/apt/lists/*
#	mariadb-client && \

RUN	mkdir -p /var/run/mysqld && \
	chown mysql:mysql /var/run/mysqld && \
	chmod 777 /var/run/mysqld

COPY 	./config/my.cnf /etc/mysql/my.cnf
COPY	./config/50-server.cnf /etc/mysql/mariadb.conf.d/

EXPOSE	3306

CMD ["mysqld", "--bind-address=0.0.0.0"]

#RUN mysql -u root -p$(cat /run/secrets/mysql_root_phrase) < /grant_privileges.sql
