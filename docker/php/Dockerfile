FROM php:8.0-alpine3.14 as php

COPY --from=composer:2.1 /usr/bin/composer /usr/local/bin/composer

ENV COMPOSER_HOME=/composer

RUN \
    apk update \
    && apk upgrade \
    && apk add --no-cache --virtual .build-deps autoconf gcc g++ make \
    && apk add --no-cache icu-dev git bash \
    && docker-php-ext-enable opcache \
    && apk del .build-deps

WORKDIR /app

# ----------------------------------------------------------------------------------------------------------------------
FROM php as dev

RUN \
    apk add --no-cache --virtual .build-deps $PHPIZE_DEPS \
    && pecl install xdebug-3.1.1 \
    && docker-php-ext-enable xdebug \
    && apk del .build-deps

# Composer tools for /bin/dev scripts
RUN \
    mkdir /composer \
    && php /usr/local/bin/composer global require \
        steevanb/php-parallel-processes "^0.2" \
        symfony/console "5.3.*" \
    && chmod -R 777 ${COMPOSER_HOME}

USER app

# ----------------------------------------------------------------------------------------------------------------------
FROM php as ci

USER app
