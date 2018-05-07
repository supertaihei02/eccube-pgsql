FROM php:7.1-alpine

# https://github.com/docker-library/wordpress/blob/master/php7.1/fpm-alpine/Dockerfile
# docker-entrypoint.sh dependencies
RUN apk add --no-cache \
      bash \
      sed

# install the PHP extensions we need
RUN set -ex; \
   \
   apk add --no-cache --virtual .build-deps postgresql-dev; \
   \
   docker-php-ext-configure pgsql --with-pgsql=/usr; \
   docker-php-ext-install pgsql; \
   \
   runDeps="$( \
      scanelf --needed --nobanner --format '%n#p' --recursive /usr/local/lib/php/extensions \
         | tr ',' '\n' \
         | sort -u \
         | awk 'system("[ -e /usr/local/lib/" $1 " ]") == 0 { next } { print "so:" $1 }' \
   )"; \
   apk add --virtual .phpexts-rundeps $runDeps; \
   apk del .build-deps

# set recommended PHP.ini settings
# see https://secure.php.net/manual/en/opcache.installation.php
RUN { \
      echo 'opcache.memory_consumption=128'; \
      echo 'opcache.interned_strings_buffer=8'; \
      echo 'opcache.max_accelerated_files=4000'; \
      echo 'opcache.revalidate_freq=2'; \
      echo 'opcache.fast_shutdown=1'; \
      echo 'opcache.enable_cli=1'; \
   } > /usr/local/etc/php/conf.d/opcache-recommended.ini

VOLUME /var/www/html

COPY docker-entrypoint.sh /usr/local/bin/

ENTRYPOINT ["docker-entrypoint.sh"]
CMD ["apache2-foreground"]

WORKDIR /tmp

# update repositories
ADD ./repositories /root/repositories
ADD ./.lftprc /root/.lftprc
RUN cp -f /root/repositories /etc/apk/repositories

WORKDIR /var/www/html
