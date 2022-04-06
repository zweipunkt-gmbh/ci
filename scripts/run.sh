#!/bin/bash

DIR="/src"

# check if source directory exists in the running container
if [ ! -d "$DIR" ]
then
# if the dir does not exist the script breaks
 echo 'You probably missed to start the container with the -v option'
 echo 'Without -v /path/host:/src you can not run this container and the tools inside '
 echo 'Please re-run the command with -v /path/from/host:/src'
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
    php -d memory_limit=4G vendor/bin/phpstan analyse -c ./config/phpstan.neon /src/$line
  done
else
  for line in $(cat $directoryfile); do
      # when the config file exissts then run more specific test
      php -d memory_limit=4G vendor/bin/phpstan analyse -c ./config/phpstan_include.neon /src/$line
  done
fi

for line in $(cat $directoryfile); do
  php -d memory_limit=4G vendor/bin/phpmd /src/$line ansi /app/config/phpmd.xml
done

for line in $(cat $directoryfile); do
  php -d memory_limit=4G vendor/bin/phpcs /src/$line --standard=/app/config/.phpcs.xml
done

#for line in $(cat $directoryfile); do
#  php -d memory_limit=4G vendor/bin/phpunit phpunit.xml
#done
