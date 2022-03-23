# Downloads the php-image based on Alpine
FROM php:7.4-alpine3.15

# Runs updates and installs some requiered apps
RUN apk update
RUN apk add bash
RUN apk add curl
RUN apk add nano

# Install Composer
RUN curl -s https://getcomposer.org/installer | php -- --install-dir=/usr/local/bin/ --filename=composer --version=2.2.9
RUN alias composer='php composer.phar'

# setting the workdir to /app
WORKDIR /app

# download the CI-tools via Composer with fix versions
RUN composer require --dev phpstan/phpstan:1.4.10
RUN composer require --dev phpmd/phpmd:2.11.1
RUN composer require --dev phpunit/phpunit:9.5.19
RUN composer require --dev squizlabs/php_codesniffer:3.6.2

# copy the startscript into the container
COPY run.sh /app

LABEL maintainer ="ZweiPunkt GmbH <entwicklung@zwei.gmbh>"

# change permissions to executable
RUN chmod +x run.sh

# auto strat the app when the container is running
CMD bash ./run.sh