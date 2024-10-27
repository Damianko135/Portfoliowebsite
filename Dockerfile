# Use a specific version of the PHP Apache image for reproducibility
FROM php:8.3.0-apache

# Install necessary packages for PHP extensions and enable Apache modules
RUN apt-get update && apt-get install -y \
        libpq-dev \
    && docker-php-ext-install pdo_mysql \
    && a2enmod rewrite \
    && apt-get clean \
    && rm -rf /var/lib/apt/lists/*

# Set the working directory
WORKDIR /var/www/html

# Copy the application code
COPY ./Index/ .

# Set proper permissions for Apache to access the files
RUN chown -R www-data:www-data /var/www/html

# Use a non-privileged user for better security
USER www-data

# Expose the port the app runs on
EXPOSE 80

# Start the Apache server
CMD ["apache2-foreground"]