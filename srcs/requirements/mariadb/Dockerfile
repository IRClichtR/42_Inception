FROM	debian:11

RUN	apt-get update && \
	apt-get install -y mariadb-server && \
	apt-get clean && \
	rm -rf /var/lib/apt/lists/*


COPY	./config/50-server.cnf /etc/mysql/mariadb.conf.d/
COPY	./config/setup_mariadb.sh /
RUN	chmod +x /setup_mariadb.sh

EXPOSE	3306

CMD	["/setup_mariadb.sh"]
#RUN mysql -u root -p$(cat /run/secrets/mysql_root_phrase) < /grant_privileges.sql
