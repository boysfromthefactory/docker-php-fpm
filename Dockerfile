FROM php:7-fpm
RUN apt-get update

RUN apt-get install -y libcurl3-dev libmcrypt-dev
RUN apt-get install -y libpng12-dev libjpeg62-turbo-dev libfreetype6-dev && docker-php-ext-configure gd --with-gd --with-freetype-dir=/usr/include/ --with-png-dir=/usr/include/ --with-jpeg-dir=/usr/include/ && docker-php-ext-install gd

RUN docker-php-ext-install mcrypt
RUN docker-php-ext-install curl
RUN docker-php-ext-install pdo_mysql
RUN docker-php-ext-install json

RUN apt-get install -y zlib1g-dev && docker-php-ext-configure zip --with-zlib-dir=/usr && docker-php-ext-install zip
RUN rm -rf /var/lib/apt/lists/*
RUN mkdir -p /var/log/fpm/ && touch /var/log/fpm/error.log && chmod 777 /var/log/fpm/error.log

WORKDIR /var/www
EXPOSE 9000
ENTRYPOINT ["php-fpm","-F"]