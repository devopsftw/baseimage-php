FROM e96tech/baseimage
MAINTAINER Alex Salt <alex.salt@e96.ru>

ENV LANG en_US.UTF-8
RUN add-apt-repository -y ppa:ondrej/php

# install packages
RUN apt-get update -qq && apt-get install --no-install-recommends -y \
    php7.0-cli php7.0-fpm php7.0-curl php7.0-json php7.0-mysql php7.0-mcrypt \
    php7.0-soap php7.0-mbstring php7.0-xml php7.0-bcmath php7.0-zip \
    php7.0-imap \
    php-apcu php-apcu-bc \
    nginx \
    git

ADD nginx.sh /etc/service/nginx/run
ADD php-fpm.sh /etc/service/php-fpm/run

# install composer
RUN curl -sS https://getcomposer.org/installer | php -- --install-dir=/usr/local/bin --filename=composer --version=1.0.0-alpha10

# configure php
ADD php/fpm/ /etc/php/7.0/fpm/
ADD php/php-cli.ini /etc/php/7.0/cli/php.ini
RUN mkdir /var/log/fpm && chown www-data:www-data /var/log/fpm

# configure nginx
ADD nginx/ /etc/nginx/

# Clean up APT when done.
RUN apt-get clean && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*
