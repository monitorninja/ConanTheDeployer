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
