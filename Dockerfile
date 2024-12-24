ARG PHP_IMAGE

FROM composer
FROM ${PHP_IMAGE}

COPY --from=composer /usr/bin/composer /usr/bin/composer
ADD --chmod=0755 https://github.com/mlocati/docker-php-extension-installer/releases/latest/download/install-php-extensions /usr/local/bin/
RUN install-php-extensions bcmath gd pdo_mysql pdo_pgsql redis yaml

# add user and group ids to match host user and group ids to avoid permission issues
ARG USER_ID
ARG GROUP_ID

# delete www-data user and recreate with host user and group ids
RUN deluser www-data
RUN if getent group www-data ; then delgroup www-data; fi
RUN addgroup -g ${GROUP_ID} -S www-data && adduser -u ${USER_ID} -D -S -G www-data www-data

USER www-data