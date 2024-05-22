FROM	debian:11

RUN	apt-get update && \
	apt-get install -y mariadb-server && \
	apt-get clean && \
	rm -rf /var/lib/apt/lists/*


ENV	ROOT_PHRASE=VeryAwsome_
ENV	DB_NAME=db1
ENV	DB_USER=ftuernal
ENV 	PASS=Awsome_


COPY	./config/50-server.cnf /etc/mysql/mariadb.conf.d/
COPY	./config/setup_mariadb.sh /

RUN	chmod 777 /setup_mariadb.sh

EXPOSE	3306

CMD	["/setup_mariadb.sh"]	


#C#MD	["bash", "-c", "mysqld_safe & sleep 5 && mysql -uroot -p$ROOT_PHRASE"]
