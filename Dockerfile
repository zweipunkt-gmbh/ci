FROM php:7.4-alpine3.15

RUN apk update
RUN apk add bash
RUN apk add curl
RUN apk add nano

# Install Composer
RUN curl -s https://getcomposer.org/installer | php -- --install-dir=/usr/local/bin/ --filename=composer --version=2.2.9
RUN alias composer='php composer.phar'

WORKDIR /src

RUN composer require --dev phpstan/phpstan:1.4.10
RUN composer require --dev phpmd/phpmd:2.11.1
RUN composer require --dev phpunit/phpunit:9.5.19
RUN composer require --dev squizlabs/php_codesniffer:3.6.2

COPY run.sh /src

LABEL maintainer ="ZweiPunkt GmbH <entwicklung@zwei.gmbh>"

RUN chmod +x run.sh