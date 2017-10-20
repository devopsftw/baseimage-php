FROM devopsftw/baseimage:xenial
MAINTAINER Alex Salt <alex.salt@e96.ru>

ENV LANG en_US.UTF-8
ENV DEBIAN_FRONTEND noninteractive
RUN add-apt-repository -y ppa:ondrej/php

# install packages
RUN apt-get update -qq && apt-get install --no-install-recommends -y \
    php5.6-cli php5.6-fpm php5.6-curl php5.6-json php5.6-mysqlnd php5.6-mcrypt \
    php5.6-gd php5.6-imagick php5.6-imap php5.6-memcache php5.6-xmlrpc \
    php5.6-bcmath php5.6-zip \
    php5.6-mbstring php5.6-soap php5.6-xml \
    nginx \
    git \

    && ln -s /etc/php/5.6 /etc/php5 \
    && ln -s /etc/php/5.6 /etc/php/current \
    && apt-get clean autoclean \
    && apt-get autoremove -y \
    && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*

ADD nginx.sh /etc/service/nginx/run
ADD php-fpm.sh /etc/service/php-fpm/run

# install composer
RUN curl -sS https://getcomposer.org/installer | php -- --install-dir=/usr/local/bin --filename=composer --version=1.0.0-alpha10

# configure php
ADD php/fpm/ /etc/php/5.6/fpm/
ADD php/php-cli.ini /etc/php/5.6/cli/php.ini
RUN mkdir /var/log/fpm && chown www-data:www-data /var/log/fpm

# configure nginx
ADD nginx/ /etc/nginx/
