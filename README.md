WHAT IS IT?
===========
Base PHP Image for application with consul agent

HOW TO USE?
-----------
Dockerfile example:

```
FROM e96tech/baseimage-php:php7
ADD some-service.json /etc/consul/conf.d/
ADD some-nginx.conf /etc/nginx/sites-enabled/
ADD pool.conf /etc/php/7.0/fpm/pool.d/
```

CONSUL
------
Consul host resolved either from `CONSUL_HOST` env var or default gateway
Put your .json configuration files to `/etc/consul/conf.d/`

Example file:
```
{
    "service" : {
        "name" : "some-php-app",
        "tags": [
            "http",
        ],
        "port" : 80
    },
    "checks" : [
        {
            "id" : "fpm",
            "service_id" : "some-php-app",
            "http" : "http://localhost/fpm_status",
            "interval" : "10s"
        }
    ]
}
```

NGINX & PHP-FPM
---------------
- add your fpm pool files to `/etc/php/7.0/fpm/pool.d/`
- add your nginx vhosts to `/etc/nginx/sites-enabled/`
