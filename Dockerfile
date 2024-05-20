FROM php:8.2-fpm-alpine as php

RUN apk add --no-cache unzip libpq-dev gnutls-dev autoconf build-base \
    curl-dev nginx supervisor shadow bash
RUN docker-php-ext-install pdo pdo_mysql
RUN pecl install pcov && docker-php-ext-enable pcov

WORKDIR /app

# Setup PHP-FPM.
COPY docker/php/php.ini $PHP_INI_DIR/
COPY docker/php/php-fpm.conf /usr/local/etc/php-fpm.d/www.conf
COPY docker/php/conf.d/opcache.ini $PHP_INI_DIR/conf.d/opcache.ini

# Setup nginx.
COPY docker/nginx/nginx.conf docker/nginx/fastcgi_params docker/nginx/fastcgi_fpm docker/nginx/gzip_params /etc/nginx/
RUN mkdir -p /var/lib/nginx/tmp /var/log/nginx
RUN /usr/sbin/nginx -t -c /etc/nginx/nginx.conf

# Setup supervisor.
COPY docker/supervisor/supervisord.conf /etc/supervisor/supervisord.conf

# Copy application sources into the container.
COPY --chown=customuser=customgroup . .

COPY --from=composer:2.7.6 /usr/bin/composer /usr/bin/composer

ENTRYPOINT ["docker/entrypoint.sh"]

CMD ["/usr/bin/supervisord", "-c", "/etc/supervisor/supervisord.conf"]