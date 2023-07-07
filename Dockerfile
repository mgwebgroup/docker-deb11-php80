# syntax=docker/dockerfile:1.2
FROM php-80-apache-xdebug-30 AS base

RUN apt-get update
RUN apt-get install -y unzip git libzip-dev

WORKDIR /tmp
COPY composer-install .
RUN ./composer-install

WORKDIR /var/www/html

COPY ssl-cert-snakeoil.crt /etc/ssl/certs/
COPY ssl-cert-snakeoil.key /etc/ssl/private/
RUN a2ensite default-ssl
COPY default-ssl.conf /etc/apache2/sites-available/

RUN /usr/local/bin/docker-php-ext-install pdo_mysql
RUN apt-get install -y libpng-dev
RUN /usr/local/bin/docker-php-ext-install gd

CMD ["apache2-foreground"]
