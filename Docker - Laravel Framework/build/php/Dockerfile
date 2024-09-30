FROM php:7.4-fpm
MAINTAINER guilhermemts

# atualizacao so, intalacao dependencias
RUN apt-get update && apt-get install -y \
        libfreetype6-dev \
        libjpeg62-turbo-dev \
        libpng-dev \
        && docker-php-ext-configure gd --with-freetype --with-jpeg \
        && docker-php-ext-install -j$(nproc) gd

# instalacao adicionais
RUN apt-get install -y \
    vim \
    git \
    curl \
    python \
    vim \
    net-tools        

# executando php-fpm
CMD [ "php-fpm" ]

# expondo porta 9000
EXPOSE 9000