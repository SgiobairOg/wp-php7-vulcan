# sgiobairog/wp-php7-vulcan
# Launches a customized version of Wordpress for local development 

# Image built on Wordpress 4.7.4 on PHP7 and Apache
FROM wordpress:4.7.4-php7.0-apache

# Install Git and Composer
RUN apt-get update \
    && apt-get install -y git zip unzip \
    && apt-get autoclean \
    && curl -sS https://getcomposer.org/installer | php -- --install-dir=/usr/local/bin --filename=composer \
    && curl -O https://raw.githubusercontent.com/wp-cli/builds/gh-pages/phar/wp-cli.phar \
    && chmod +x wp-cli.phar \
    && mv wp-cli.phar /usr/local/bin/wp

# Copy all plugins
# In production this build should be handled by a CI event that will grab the latest version of the plugins and
# trigger a new build of this image when a plugin is updated.
WORKDIR /var/www/html/wp-content
COPY ./plugins ./plugins

WORKDIR /var/www/html/wp-content/plugins
COPY ./build-scripts/plugins.sh ./plugins.sh
RUN chmod +x ./plugins.sh \
    && ./plugins.sh 

WORKDIR /var/www/html
COPY ./wp-config.php ./wp-config.php
COPY ./build-scripts/install.sh ./install.sh

RUN chmod +x install.sh