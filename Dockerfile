
#using this awesome prebuild image:
 FROM 'fadhilihsn/php-7.1-ngix:cicd'
 MAINTAINER fadhilihsn <fadhilihsn@gmail.com>

#install prestissimo for faster deps instalation
RUN composer global require hirak/prestissimo

#make directory for hosting the apps
RUN mkdir /home/app/app
WORKDIR /home/app/app

#install dependencies
COPY composer.json compose.json
RUN composer install --prefer-dist --no-scripts --no-dev --no-autoloader && rm -rf /home/app/.composer

#copy codebase
COPY --chown=app:root . ./


#finish composer
#run composer dump-autoload
RUN composer dump-autoload --no-scripts --no-dev --optimize

EXPOSE 8080