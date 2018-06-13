FROM devopsftw/baseimage:0.4.1
MAINTAINER Alex Salt <alex.salt@e96.ru>

ENV COMPOSER_VERSION 1.5.5
RUN LC_ALL=C.UTF-8 add-apt-repository -y ppa:ondrej/php

# install packages
RUN apt-get update -qq && apt-get install --no-install-recommends -y \
    php7.2-cli \
    php7.2-fpm \
    php7.2-curl \
    php7.2-json \
    php7.2-mysql \
    php7.2-soap \
    php7.2-mbstring \
    php7.2-xml \
    php7.2-bcmath \
    php7.2-zip \
    php7.2-imap \
    php7.2-intl \
    php-xdebug \
    php-apcu php-apcu-bc \
    php-imagick php-memcache \
    nginx \
    git \
    && phpdismod xdebug \
    && ln -s /etc/php/7.2 /etc/php/current \
    && apt-get clean autoclean \
    && apt-get autoremove -y \
    && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*

COPY nginx.sh /etc/service/nginx/run
COPY php-fpm.sh /etc/service/php-fpm/run

# install composer
RUN curl -sS https://getcomposer.org/installer | php -- --install-dir=/usr/local/bin --filename=composer --version=${COMPOSER_VERSION}

# configure php
COPY php/fpm/ /etc/php/7.2/fpm/
COPY php/php-cli.ini /etc/php/7.2/cli/php.ini
RUN mkdir /var/log/fpm && chown www-data:www-data /var/log/fpm

# configure nginx
COPY nginx/ /etc/nginx/
