# srcs/requirements/nginx/Dockerfile
FROM debian:bullseye

# Update and Upgrade apt packages
RUN apt-get update
RUN apt upgrade -y

# Install OpenSSL
RUN apt-get install -y openssl && mkdir -p /etc/nginx/ssl
RUN openssl req -newkey rsa:4096 -x509 -sha256 -days 365 -nodes -out /etc/nginx/ssl/cert.pem -keyout /etc/nginx/ssl/key.pem -subj "/CN=ftuernal.42.fr"

# Install NGINX and PHP-FPM
RUN apt-get install nginx php-fpm -y

# Copy NGINX Configuration
COPY ./conf /etc/nginx/conf.d
COPY ./default /etc/nginx/sites-available/default

# Expose port 443 for HTTPS
EXPOSE 443

# Start NGINX in the foreground
CMD ["nginx", "-g", "daemon off;"]
