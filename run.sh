#!/bin/bash

DIR="/src"

# check if source directory exists in the running container
if [ ! -d "$DIR" ]
then
# if the dir does not exist the script breaks
 echo 'Directory /src does not exist.'
 exit 1
fi

input="/src/ci.txt"
while IFS= read -r line
do
  echo "$line"

  # check if config 1 exists PHPStan
  if [ ! -e phpstan.neon ]
  then
  # file exists run phpstan with memory limit of 4G
    php -d memory_limit=4G vendor/bin/phpstan analyse $line -c /src/phpstan.neon
  else
  # file does not exist skip the test
    echo 'File phpstan.neon does not exist'
  fi

done < "$input"

# check if config 2 exists PHPMD
if [ ! -e phpmd.xml ]
then
# file exists run phpmd with memory limit of 4G
  php -d memory_limit=4G vendor/bin/phpmd /path/to/code ansi /src/phpmd.xml
else
# file does not exist skip the test
  echo 'File phpmd.xml does not exist'
fi

# check if config 3  exists PHPCodesniffer
if [ ! -e .phpcs.xml ]
then
# file exists run phpcs with memory limit of 4G
  php -d memory_limit=4G vendor/bin/phpcs --standard=/src/.phpcs.xml
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
