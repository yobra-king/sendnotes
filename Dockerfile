FROM php:8.3-fpm

# Install system dependencies
RUN apt-get update && apt-get install -y --no-install-recommends \
    curl \
    git \
    unzip \
    libpng-dev \
    libonig-dev \
    libxml2-dev \
    libzip-dev \
    libcurl4-openssl-dev \
    && docker-php-ext-install -j$(nproc) \
    pdo_mysql \
    pdo_pgsql \
    mbstring \
    gd \
    zip \
    xml \
    ctype \
    tokenizer \
    dom \
    fileinfo \
    filter \
    hash \
    session \
    openssl \
    && apt-get clean \
    && rm -rf /var/lib/apt/lists/*

# Install Composer globally
RUN curl -sS https://getcomposer.org/installer | php -- --install-dir=/usr/local/bin --filename=composer \
    && composer --version

# Set working directory
WORKDIR /var/www

# Copy project files
COPY . .

# Check contents of the directory
RUN ls -al /var/www

# Install Laravel dependencies
RUN composer install --optimize-autoloader --no-dev

# Set permissions
RUN chown -R www-data:www-data /var/www \
    && chmod -R 755 /var/www/storage

# Expose port 80
EXPOSE 80

# Run PHP-FPM
CMD ["php-fpm"]
