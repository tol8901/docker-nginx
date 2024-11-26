FROM nginx:1.12.0-alpine

# Install envsubst
RUN apk add --no-cache gettext

# Copy the HTML files
COPY ./html /usr/share/nginx/html

# Copy the authentication file
COPY ./.htpasswd /etc/nginx/.htpasswd

# Copy the template configuration file
COPY config.d/default.conf.template /etc/nginx/conf.d/default.conf.template

# Use envsubst to replace environment variables and start Nginx
CMD ["/bin/sh", "-c", "envsubst '${EXTERNAL_PORT}' < /etc/nginx/conf.d/default.conf.template > /etc/nginx/conf.d/default.conf && nginx -g 'daemon off;'"]
