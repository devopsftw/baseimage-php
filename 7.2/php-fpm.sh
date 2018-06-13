#!/bin/sh

_term() {
    kill -QUIT $pid
    wait $pid
}
# trap term for gracefully stopping php-fpm
trap _term TERM

/usr/sbin/php-fpm7.1 --nodaemonize --fpm-config /etc/php/7.1/fpm/php-fpm.conf &
pid=$!
wait $pid
