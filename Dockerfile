FROM alpine:latest
WORKDIR /var/www/html

RUN apk add --no-cache \
  mc \
  vim \
  nginx \
  php8 \
  php8-ctype \
  php8-curl \
  php8-dom \
  php8-fpm \
  php8-gd \
  php8-intl \
  php8-json \
  php8-mbstring \
  php8-mysqli \
  php8-opcache \
  php8-openssl \
  php8-phar \
  php8-session \
  php8-xml \
  php8-xmlreader \
  php8-zlib \
  supervisor

RUN ln -s /usr/bin/php8 /usr/bin/php

# Configure supervisord
COPY config/supervisord.conf /etc/supervisor/conf.d/supervisord.conf
COPY config/http.d /etc/nginx/http.d

# Configure nginx
# COPY config/nginx.conf /etc/nginx/nginx.conf

# Configure PHP-FPM
COPY config/fpm-pool.conf /etc/php8/php-fpm.d/www.conf
COPY config/php.ini /etc/php8/conf.d/custom.ini

RUN chown -R nobody.nobody /var/www/html /run /var/lib/nginx /var/log/nginx

USER nobody

COPY --chown=nobody src/ /var/www/html/

COPY src/index.html /usr/share/nginx/html

# Expose ports.
EXPOSE 80

CMD ["/usr/bin/supervisord", "-c", "/etc/supervisor/conf.d/supervisord.conf"]