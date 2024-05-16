###################### Use appropriate Debian version #######################

FROM debian:11


###################### Install and Update NGINX #######################

RUN 	apt-get update && \
	apt-get install -y nginx && \
	rm -rf /var/lib/apt/lists/* # clean up after installation




###################### Install and Update NGINX #######################

RUN 	useradd -r -s /bin/false nginx
COPY	config/nginx.conf /etc/nginx/nginx.conf
RUN	mkdir -p /var/www/html && \
	chown -R root:root /var/www/html && \
	chown -R nginx:nginx /var/www/html && \
	chmod 775 /var/log/nginx && \
	chown www-data:www-data /var/log/nginx

###################### Expose PORTS #######################

EXPOSE 443


###################### Start NGINX #######################

CMD ["nginx", "-g", "daemon off;"]


###################### Health-check NGINX #######################

