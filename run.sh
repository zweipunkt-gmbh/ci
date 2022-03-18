#!/bin/bash

DIR="/usr/src/myapp/source"

# check if source directory exists in the running container
if [ ! -d "$DIR" ]
then
# if the dir does not exist the script breaks
 echo 'Directory /usr/src/myapp/source does not exist.'
 exit 1
fi

# check if config 1 exists PHPStan
if [ ! -e phpstan.neon ]
then
# file exists run phpstan with memory limit of 4G
  php -d memory_limit=4G vendor/bin/phpstan analyse -c source/phpstan.neon
else
# file does not exist skip the test
  echo 'File phpstan.neon does not exist'
fi

# check if config 2 exists PHPMD
if [ ! -e phpmd.xml ]
then
# file exists run phpmd with memory limit of 4G
  php -d memory_limit=4G vendor/bin/phpmd text source/phpmd.xml
else
# file does not exist skip the test
  echo 'File phpmd.xml does not exist'
fi

# check if config 3  exists PHPCodesniffer
if [ ! -e .phpcs.xml ]
then
# file exists run phpcs with memory limit of 4G
  php -d memory_limit=4G vendor/bin/phpcs --standard=./source/.phpcs.xml
else
# file does not exist skip the test
  echo 'File .phpcs.xml does not exist'
fi

# check if config 4 exists PHPUnit
if [ -f "source/phpunit.xml" ];
then
# file exists run phpunit with memory limit of 4G
  php -d memory_limit=4G vendor/bin/phpunit source/public/custom/plugins/ZweiPunktOfferDocument/ZweiPunktOfferDocument.php
else
# file does not exist skip the test
  echo 'File phpunit.xml does not exist'
fi
