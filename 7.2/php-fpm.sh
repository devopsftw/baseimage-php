#!/bin/sh

_term() {
    kill -QUIT $pid
    wait $pid
}
# trap term for gracefully stopping php-fpm
trap _term TERM

/usr/sbin/php-fpm-current --nodaemonize --fpm-config /etc/php/current/fpm/php-fpm.conf &
pid=$!
wait $pid
