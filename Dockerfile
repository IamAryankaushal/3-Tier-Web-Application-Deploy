# -------------------------------
# 1. Base image: PHP + Apache
# -------------------------------
FROM php:8.2-apache

# -------------------------------
# 2. Install system dependencies
# -------------------------------
RUN apt-get update && apt-get install -y \
    libpng-dev \
    libjpeg-dev \
    libfreetype6-dev \
    libzip-dev \
    libicu-dev \
    libonig-dev \
    unzip \
    curl \
    && rm -rf /var/lib/apt/lists/*

# -------------------------------
# 3. Install PHP extensions required by WordPress
# -------------------------------
RUN docker-php-ext-configure gd --with-freetype --with-jpeg \
    && docker-php-ext-install -j$(nproc) \
        mysqli \
        pdo_mysql \
        gd \
        intl \
        zip \
        mbstring \
        exif \
        opcache

# -------------------------------
# 4. Enable Apache modules
# -------------------------------
RUN a2enmod rewrite

# -------------------------------
# 5. Set working directory
# -------------------------------
WORKDIR /var/www/html

# -------------------------------
# 6. Copy WordPress source code
# -------------------------------
COPY app/ /var/www/html/

# -------------------------------
# 7. Set permissions
# -------------------------------
RUN chown -R www-data:www-data /var/www/html \
    && chmod -R 755 /var/www/html

# -------------------------------
# 8. Expose HTTP port
# -------------------------------
EXPOSE 80

# -------------------------------
# 9. Start Apache
# -------------------------------
CMD ["apache2-foreground"]
