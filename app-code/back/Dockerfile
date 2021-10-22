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

RUN docker-php-ext-install zip pdo_mysql calendar

WORKDIR /code
COPY . .

COPY --from=composer:2.1.0 /usr/bin/composer /usr/local/bin/composer

RUN composer install --ignore-platform-reqs --no-interaction

RUN apt-get update -y \
    && apt-get install wget \
    zip \
    xvfb \
    libxrender1 \
    xfonts-75dpi \
    fontconfig -y

RUN wget https://github.com/mikefarah/yq/releases/download/v4.13.4/yq_linux_amd64 -O /usr/bin/yq \
    && chmod +x /usr/bin/yq

RUN wget https://github.com/wkhtmltopdf/packaging/releases/download/0.12.6-1/wkhtmltox_0.12.6-1.buster_amd64.deb -O /tmp/wkhtmltox.deb \
    && dpkg -i /tmp/wkhtmltox.deb \
    && apt-get install -f -y

COPY docker-nginx.conf /etc/nginx/sites-enabled/default
ADD /docker-start.sh /docker-start.sh

EXPOSE 80

RUN ["chmod", "+x", "/docker-start.sh"]
CMD ["/docker-start.sh"]
