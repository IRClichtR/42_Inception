###################### Use appropriate Debian version #######################

FROM debian:11


###################### Install and Update NGINX #######################

RUN 	apt-get update && \
	apt-get install -y nginx openssl && \
	rm -rf /var/lib/apt/lists/* # clean up after installation


###################### SSH KEY PRODUCTION #######################

RUN	mkdir /etc/nginx/ssl
RUN 	openssl req -newkey rsa:4096 -x509 -sha256 -days 365 -nodes \
	-out /etc/nginx/ssl/ftuernal.crt \
	-keyout /etc/nginx/ssl/ftuernal.key \
	-subj "/C=FR/L=Paris/O=42/OU=Student/ST=Ile de France/CN=ftuernal.42.fr"



###################### Install and Update NGINX #######################

COPY	./config/nginx.conf /etc/nginx/nginx.conf
RUN	mkdir -p /run/nginx

###################### Expose PORTS #######################

EXPOSE 443


###################### Start NGINX #######################

CMD ["nginx", "-g", "daemon off;"]
