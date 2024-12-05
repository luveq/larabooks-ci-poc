FROM dunglas/frankenphp:1.3-php8.4

# ------------------------------------------------------------------------------
#   Setup Dependencies
# ------------------------------------------------------------------------------
RUN install-php-extensions \
    pdo_mysql \
    gd \
    intl \
    zip \
    opcache

RUN apt-get update && apt-get install -y \
    libnss3-tools \
    unzip

COPY --from=composer/composer:2-bin /composer /usr/bin/composer

# ------------------------------------------------------------------------------
#   Copy Repository
# ------------------------------------------------------------------------------
COPY . /app
WORKDIR /app

# ------------------------------------------------------------------------------
#   Setup Permissions
# ------------------------------------------------------------------------------
ARG USER=www-data

RUN    chown -R $USER:$USER /data/caddy \
    && chown -R $USER:$USER /config/caddy \
    && chown -R :$USER /app \
    && chmod -R 770 /data/caddy /config/caddy /app \
    && chmod +x docker/local/post_start.sh

# Add additional capability to bind to port 80 and 443
RUN setcap CAP_NET_BIND_SERVICE=+eip /usr/local/bin/frankenphp

# ------------------------------------------------------------------------------
#   Set User
# ------------------------------------------------------------------------------
USER ${USER}
