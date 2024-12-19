# Use the official PHP image with FPM
FROM php:8.3-fpm

# Install system dependencies and required libraries
RUN apt-get update && apt-get install -y \
    curl \
    git \
    unzip \
    autoconf \
    build-essential \
    libpng-dev \
    libonig-dev \
    libxml2-dev \
    libzip-dev \
    libcurl4-openssl-dev \
    libpq-dev \
    libfreetype6-dev \
    libjpeg62-turbo-dev \
    nginx \
    && docker-php-ext-configure gd --with-freetype --with-jpeg \
    && docker-php-ext-install \
    pdo_mysql \
    mbstring \
    gd \
    zip \
    xml \
    ctype \
    dom \
    fileinfo \
    filter \
    hash \
    openssl \
    pcre \
    pdo \
    session \
    tokenizer \
    pdo_pgsql \
    && apt-get clean && rm -rf /var/lib/apt/lists/*

# Install Composer globally
RUN curl -sS https://getcomposer.org/installer | php -- --install-dir=/usr/local/bin --filename=composer

# Set working directory
WORKDIR /var/www

# Copy Laravel files to the container
COPY . .

# Install Laravel dependencies
RUN composer install --optimize-autoloader --no-dev

# Set permissions for storage and cache
RUN chown -R www-data:www-data /var/www \
    && chmod -R 755 /var/www/storage

# Copy Nginx configuration
COPY ./nginx/laravel.conf /etc/nginx/sites-available/default

# Expose port 80
EXPOSE 80

# Start services using a custom bash script
CMD ["./start-container.sh"]
