FROM nginx:1.21-alpine

RUN apk add --no-cache php php-fpm php-mysql php-curl php-json php-opcache php-xml php-mbstring

RUN mkdir -p /var/www/html
WORKDIR /var/www/html

RUN curl -o latest.tar.gz -SL https://wordpress.org/latest.tar.gz \
  && tar -xzf latest.tar.gz --strip-components=1 \
  && rm latest.tar.gz

COPY nginx.conf /etc/nginx/nginx.conf

EXPOSE 80
CMD ["nginx", "-g", "daemon off;"]

# Install and configure WordPress
RUN chown -R www-data:www-data /var/www/html
RUN chmod -R 755 /var/www/html
RUN cp wp-config-sample.php wp-config.php
RUN sed -i "s/database_name_here/your_database_name/g" wp-config.php
RUN sed -i "s/username_here/your_username/g" wp-config.php
RUN sed -i "s/password_here/your_password/g" wp-config.php

# Install and configure MySQL client
RUN apk add --no-cache mysql-client

# Set up entrypoint script
COPY entrypoint.sh /usr/local/bin/
RUN chmod +x /usr/local/bin/entrypoint.sh
ENTRYPOINT ["/usr/local/bin/entrypoint.sh"]

