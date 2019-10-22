# from https://www.drupal.org/docs/8/system-requirements/drupal-8-php-requirements
FROM drupal:8.7.8-fpm

# Remove base image drupal code
RUN rm -rf /var/www/html

# Install git
RUN apt-get update && apt-get install git -y

# Installing composer
RUN php -r "copy('https://getcomposer.org/download/1.9.0/composer.phar', 'composer.phar');" && \
    php -r "if (hash_file('sha256', 'composer.phar') === 'c9dff69d092bdec14dee64df6677e7430163509798895fbd54891c166c5c0875') { echo 'Composer verified'; } else { echo 'Composer corrupted'; unlink('composer.phar'); } echo PHP_EOL;" && \
    chmod 755 composer.phar && \
    mv composer.phar /usr/local/bin/composer

WORKDIR /app

# Install composer plugin for parallel installs
RUN composer global require hirak/prestissimo

# Copy only required files to run composer install
COPY scripts/composer scripts/composer
COPY composer.json composer.json
COPY composer.lock composer.lock

# Install project
RUN composer install --no-interaction --no-progress

# Add vendor/bin folder to path
ENV PATH="/app/vendor/bin:${PATH}"

# Copy project files
COPY . .
