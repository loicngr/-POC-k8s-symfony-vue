FROM php:7.4-fpm

RUN apt-get update && apt-get install -y \
    git \
    nginx

RUN apt-get install -y \
        libfreetype6-dev \
        libjpeg62-turbo-dev \
        libpng-dev \
        libzip-dev \
    && docker-php-ext-configure gd --with-freetype --with-jpeg \
    && docker-php-ext-install -j$(nproc) gd

RUN docker-php-ext-install zip pdo_mysql

WORKDIR /code
COPY . .

COPY --from=composer:2.1.0 /usr/bin/composer /usr/local/bin/composer

RUN composer install --ignore-platform-reqs --no-interaction

COPY docker-nginx.conf /etc/nginx/sites-enabled/default
ADD /docker-start.sh /docker-start.sh

EXPOSE 80

RUN ["chmod", "+x", "/docker-start.sh"]
CMD ["/docker-start.sh"]