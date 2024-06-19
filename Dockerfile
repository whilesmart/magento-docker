FROM php:8.1-apache

# Update and install Apache, PHP 8.1 with mod_php, and other dependencies
RUN apt-get update && apt-get install -y \
    iputils-ping \
    wget \
    curl \
    git \
    unzip \
    vim

# Enable necessary Apache modules
RUN a2enmod rewrite

ADD --chmod=0755 https://github.com/mlocati/docker-php-extension-installer/releases/latest/download/install-php-extensions /usr/local/bin/

RUN install-php-extensions bcmath \
        bz2 \
        calendar \
        curl \
        exif \
        fileinfo \
        ftp \
        gd \
        gettext \
        imagick \
        imap \
        intl \
        ldap \
        mbstring \
        mcrypt \
        memcached \
        mongodb \
        mysqli \
        opcache \
        openssl \
        pdo \
        pdo_mysql \
        redis \
        sockets \
        soap \
        sodium \
        sysvsem \
        sysvshm \
        xmlrpc \
        xsl \
        zip

# Increase PHP memory limit
RUN echo "memory_limit=256M" > /usr/local/etc/php/conf.d/memory-limit.ini

# Copy the virtual host configuration
COPY 000-default.conf /etc/apache2/sites-available/000-default.conf

# Set working directory
WORKDIR /var/www/html

# Install Composer
RUN curl -sS https://getcomposer.org/installer | php -- --install-dir=/usr/local/bin --filename=composer

# Make sure to clean up
RUN apt-get clean && rm -rf /var/lib/apt/lists/*

# Expose port 80
EXPOSE 80

# Start Apache in the foreground
CMD ["apachectl", "-D", "FOREGROUND"]
