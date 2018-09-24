FROM devopsftw/baseimage:0.4.1
MAINTAINER Alex Salt <alex.salt@e96.ru>

ENV PHP_VERSION 7.2
ENV COMPOSER_VERSION 1.5.5
RUN LC_ALL=C.UTF-8 add-apt-repository -y ppa:ondrej/php

# install packages
RUN apt-get update -qq && apt-get install --no-install-recommends -y \
    php${PHP_VERSION}-cli \
    php${PHP_VERSION}-fpm \
    php${PHP_VERSION}-curl \
    php${PHP_VERSION}-json \
    php${PHP_VERSION}-mysql \
    php${PHP_VERSION}-soap \
    php${PHP_VERSION}-mbstring \
    php${PHP_VERSION}-xml \
    php${PHP_VERSION}-bcmath \
    php${PHP_VERSION}-zip \
    php${PHP_VERSION}-imap \
    php${PHP_VERSION}-intl \
    php-xdebug \
    php-apcu php-apcu-bc \
    php-imagick php-memcache \
    nginx \
    git \
    && phpdismod xdebug \
    && ln -s /etc/php/${PHP_VERSION} /etc/php/current \
    && ln -s /usr/sbin/php-fpm${PHP_VERSION} /usr/sbin/php-fpm-current
    && apt-get clean autoclean \
    && apt-get autoremove -y \
    && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*

COPY nginx.sh /etc/service/nginx/run
COPY php-fpm.sh /etc/service/php-fpm/run

# install composer
RUN curl -sS https://getcomposer.org/installer | php -- --install-dir=/usr/local/bin --filename=composer --version=${COMPOSER_VERSION}

# configure php
COPY php/fpm/ /etc/php/current/fpm/
COPY php/php-cli.ini /etc/php/current/cli/php.ini
RUN mkdir /var/log/fpm && chown www-data:www-data /var/log/fpm

# configure nginx
COPY nginx/ /etc/nginx/
