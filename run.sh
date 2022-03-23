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

if [ ! -e phpstan.neon ]; then

  while IFS= read -r line ;do
      #file exists run phpstan with memory limit of 4G
      php -d memory_limit=4G vendor/bin/phpstan analyse $line -c /src/phpstan.neon
  done < $input
else
  echo 'cfg-File phpstan.neon does not exist'
fi

if [ ! -e phpmd.xml ]; then

  while IFS= read -r line ;do
      #file exists run phpmd with memory limit of 4G
      php -d memory_limit=4G vendor/bin/phpmd $line ansi /src/phpmd.xml
  done < $input
else
  echo 'cfg-File phpmd.xml does not exist'
fi

echo "Ab hier sollte PHPCodesniffer übernehmen in einer Schleife"

if [ ! -e .phpcs.xml ]; then
    while IFS= read -r line; do
        # file exists run phpcs with memory limit of 4G
        php -d memory_limit=4G vendor/bin/phpcs --standard=/src/.phpcs.xml $line
    done < $input
fi

## check if config 4 exists PHPUnit
#if [ -f "source/phpunit.xml" ];
#then
## file exists run phpunit with memory limit of 4G
#  php -d memory_limit=4G vendor/bin/phpunit source/public/custom/plugins/ZweiPunktOfferDocument/ZweiPunktOfferDocument.php
#else
## file does not exist skip the test
#  echo 'File phpunit.xml does not exist'
#fi
