# Set master image
FROM php:7.3-fpm-alpine

# Copy composer.lock and composer.json
#COPY composer.lock composer.json /var/www/

# Set working directory
WORKDIR /var/www

# Install dependencies
RUN apk update && apk add --no-cache \
  bash \
  build-base shadow vim curl \
  php7 \
  php7-fpm \
  php7-common \
  php7-pdo \
  php7-pdo_mysql \
  php7-mysqli \
  php7-mcrypt \
  php7-mbstring \
  php7-xml \
  php7-openssl \
  php7-json \
  php7-phar \
  php7-zip \
  php7-gd \
  php7-dom \
  php7-session \
  php7-zlib \
  zip libzip-dev


# Add and Enable PHP-PDO Extenstions
RUN docker-php-ext-install pdo_mysql

#RUN docker-php-ext-install pdo pdo_mysql
#RUN docker-php-ext-enable pdo_mysql

RUN docker-php-ext-install zip exif

# Add gd extension
RUN apk add --no-cache freetype libpng libjpeg-turbo freetype-dev libpng-dev libjpeg-turbo-dev && \
  docker-php-ext-configure gd \
  --with-gd \
  --with-freetype-dir=/usr/include/ \
  --with-png-dir=/usr/include/ \
  --with-jpeg-dir=/usr/include/ && \
  NPROC=$(grep -c ^processor /proc/cpuinfo 2>/dev/null || 1) && \
  docker-php-ext-install -j${NPROC} gd && \
  apk del --no-cache freetype-dev libpng-dev libjpeg-turbo-dev

# Add php.ini
RUN cp /usr/local/etc/php/php.ini-development /usr/local/etc/php/php.ini 

# Install Composer
RUN curl -sS https://getcomposer.org/installer | php -- --install-dir=/usr/local/bin --filename=composer

# Add nodejs and npm
RUN apk add --update nodejs npm
RUN npm i -g nodemon
# Remove Cache
RUN rm -rf /var/cache/apk/*

# Add user for laravel application
RUN groupadd -g 1000 www
RUN useradd -u 1000 -ms /bin/bash -g www www
#RUN usermod -u 1000 www-data
RUN apk add -y --no-cache git

RUN echo 'root:docker-secret' | chpasswd

RUN chown www:www /usr/local/bin/composer


COPY --chown=www:www auth.json /var/www/.composer/
COPY --chown=www:www .bashrc /home/www/

USER www

# Change current user to www

# Copy existing application directory permissions
#COPY --chown=www:www . /var/www
WORKDIR /var/www/.composer

RUN composer global require laravel/installer

# CMD ["/usr/local/bin/composer",  "global", "require", "laravel/installer"]
# RUN composer global require laravel/installer

CMD ["/bin/source","/home/www/.bashrc"]




# Expose port 9000 and start php-fpm server
#EXPOSE 9000
CMD ["php-fpm"]


EXPOSE 8080
EXPOSE 3001
EXPOSE 3002
