FROM alpine:3.5
MAINTAINER jovani <vojalf@gmail.com>

RUN apk upgrade -q -U -a \
    && apk --no-cache add php7 php7-fpm php7-mysqli php7-json php7-openssl php7-curl php7-gd php7-zip \
    php7-zlib php7-xml php7-phar php7-intl php7-dom php7-simplexml php7-tokenizer php7-xmlreader php7-xmlwriter php7-ctype \
    php7-mbstring php7-session php7-pdo php7-pdo_mysql php7-mongodb php7-fileinfo php7-memcached nginx supervisor curl \
    --repository http://dl-cdn.alpinelinux.org/alpine/edge/main/ \
    --repository http://dl-cdn.alpinelinux.org/alpine/edge/testing/ \
    --repository http://dl-cdn.alpinelinux.org/alpine/edge/community/

RUN curl -sS https://getcomposer.org/installer | php -- --install-dir=/usr/bin/ && mv /usr/bin/composer.phar /usr/bin/composer

RUN /usr/bin/composer global require "fxp/composer-asset-plugin:^1.3.1"

COPY nginx.conf /etc/nginx/nginx.conf

COPY php.ini /etc/php7/conf.d/custom.ini
COPY php-fpm.conf /etc/php7/php-fpm.d/custom.conf

COPY supervisord.conf /etc/supervisor/conf.d/supervisord.conf

RUN mkdir /scripts/
ADD run.sh /scripts/run.sh
RUN chmod 755 /scripts/*.sh

WORKDIR /var/www

EXPOSE 80 443
CMD ["/scripts/run.sh"]