FROM 	debian:11

RUN	apt-get update && \
	apt-get isntall -y nginx && \
	rm -rf /var/lib/apt/lists/*

CMD 	["nginx", "-g", "daemon off;"]
