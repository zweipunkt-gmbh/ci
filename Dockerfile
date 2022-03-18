LABEL maintainer ="ZweiPunkt GmbH <entwicklung@zwei.gmbh>"

# get the composer-image
FROM composer:2.2.9 AS composer

# get the php-buster-image
FROM php:7.4-cli-buster AS php

# check if updates avaliable, install zip, unzip, git, nano
RUN apt update
RUN apt install software-properties-common -y
RUN apt install zip unzip git nano -y

# get file from composer into the container
COPY --from=composer /usr/bin/composer /usr/bin/composer

# copy Directory in /usr/src/myapp
COPY . /usr/src/myapp

# set the Workingdirectory to /usr/src/myapp
WORKDIR /usr/src/myapp

# get the ci tools phpstan, phpmd, phpcs and phpunit
RUN composer require --dev phpstan/phpstan:1.4.10
RUN composer require --dev phpmd/phpmd:2.11.1
RUN composer require --dev squizlabs/php_codesniffer:3.6.2
RUN composer require --dev phpunit/phpunit:9.5.19

# get permission to read and write the file run.sh
RUN chmod +x run.sh

# start the run.sh file
CMD bash run.sh