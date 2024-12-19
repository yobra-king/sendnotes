# Base image for PHP
FROM php:8.2-fpm

# Install system dependencies and extensions
RUN apt-get update && apt-get install -y \
    nginx \
    curl \
    git \
    unzip \
    libpq-dev \
    libzip-dev \
    && docker-php-ext-install pdo pdo_pgsql zip

# Install Composer
RUN curl -sS https://getcomposer.org/installer | php -- --install-dir=/usr/local/bin --filename=composer

# Set working directory
WORKDIR /var/www/html

# Copy Laravel files
COPY . .

# Install PHP dependencies
RUN composer install --no-dev --optimize-autoloader

# Permissions
RUN chown -R www-data:www-data /var/www/html/storage /var/www/html/bootstrap/cache

# Copy Nginx configuration
COPY nginx.conf /etc/nginx/nginx.conf

# Expose ports
EXPOSE 80

# Start Nginx and PHP-FPM
CMD service nginx start && php-fpm
