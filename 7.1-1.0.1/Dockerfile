FROM devopsftw/baseimage:0.4.0
MAINTAINER Alex Salt <alex.salt@e96.ru>

ENV COMPOSER_VERSION 1.5.5
RUN LC_ALL=C.UTF-8 add-apt-repository -y ppa:ondrej/php

# install packages
RUN apt-get update -qq && apt-get install --no-install-recommends -y \
    php7.1-cli \
    php7.1-fpm \
    php7.1-curl \
    php7.1-json \
    php7.1-mysql \
    php7.1-mcrypt \
    php7.1-soap \
    php7.1-mbstring \
    php7.1-xml \
    php7.1-bcmath \
    php7.1-zip \
    php7.1-imap \
    php7.1-intl \
    php-xdebug \
    php-apcu php-apcu-bc \
    php-imagick php-memcache \
    nginx \
    git \
    && phpdismod xdebug \
    && ln -s /etc/php/7.1 /etc/php/current \
    && apt-get clean autoclean \
    && apt-get autoremove -y \
    && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*

COPY nginx.sh /etc/service/nginx/run
COPY php-fpm.sh /etc/service/php-fpm/run

# install composer
RUN curl -sS https://getcomposer.org/installer | php -- --install-dir=/usr/local/bin --filename=composer --version=${COMPOSER_VERSION}

# configure php
COPY php/fpm/ /etc/php/7.1/fpm/
COPY php/php-cli.ini /etc/php/7.1/cli/php.ini
RUN mkdir /var/log/fpm && chown www-data:www-data /var/log/fpm

# configure nginx
COPY nginx/ /etc/nginx/
