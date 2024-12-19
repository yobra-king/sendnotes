#!/usr/bin/env bash
echo "Installing Composer dependencies..."
composer install --no-dev --optimize-autoloader

echo "Caching Laravel config and routes..."
php artisan config:cache
php artisan route:cache

echo "Setting up storage symlinks..."
php artisan storage:link

echo "Running database migrations..."
php artisan migrate --force
