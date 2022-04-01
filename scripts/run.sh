#!/bin/bash

DIR="/src"

# check if source directory exists in the running container
if [ ! -d "$DIR" ]
then
# if the dir does not exist the script breaks
 echo 'Directory /src does not exist.'
 exit 1
fi

# specify the path where the file with the DIR's is located
# this file should be located in the repositories Root-Dir
directoryfile="/src/ci.txt"

# check if file not exists
if [ ! -e $directoryfile ]; then
    echo "No ci.txt found in your repository root"
    echo "Please add ci.txt to the repository root and provide paths for sourcecode checks"
    exit 1
fi

configrepospecific="/src/phpstan.neon"

# checks if not in the mapped repository a phpstan.neon exists
if [ ! -e $configrepospecific ]; then
  for line in $(cat $directoryfile); do
    # when no file exists run the main tests
    php -d memory_limit=4G vendor/bin/phpstan analyse -c ./config/phpstan.neon $line
  done
else
  for line in $(cat $directoryfile); do
      # when the config file exissts then run more specific test
      php -d memory_limit=4G vendor/bin/phpstan analyse -c ./config/phpstan_include.neon $line
  done
fi

for line in $(cat $directoryfile); do
  php -d memory_limit=4G vendor/bin/phpmd $line ansi /app/config/phpmd.xml
done

for line in $(cat $directoryfile); do
  php -d memory_limit=4G vendor/bin/phpcs $line --standard=/app/config/.phpcs.xml
done

#for line in $(cat $directoryfile); do
#  php -d memory_limit=4G vendor/bin/phpunit phpunit.xml
#done
