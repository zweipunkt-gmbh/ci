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

if [ ! -e $directoryfile ]; then
    echo "No File with paths provided in /src"
    exit 1
fi

for line in $(cat $directoryfile); do
  #file exists run phpstan with memory limit of 4G
  php -d memory_limit=4G vendor/bin/phpstan analyse -c ./config/phpstan.neon $line
done

for line in $(cat $directoryfile); do
  #file exists run phpmd with memory limit of 4G
  php -d memory_limit=4G vendor/bin/phpmd $line ansi /app/config/phpmd.xml
done

for line in $(cat $directoryfile); do
  echo "tester: $line"
  php -d memory_limit=4G vendor/bin/phpcs $line --standard=/app/config/.phpcs.xml
done

#for line in $(cat $directoryfile); do
#  # file exists run phpunit with memory limit of 4G
#  php -d memory_limit=4G vendor/bin/phpunit phpunit.xml
#done
