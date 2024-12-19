#!/bin/bash

# Start Nginx in the background
service nginx start

# Run Laravel-specific commands
php artisan config:cache
php artisan route:cache
php artisan view:cache
php artisan migrate --force

# Start PHP-FPM
php-fpm
