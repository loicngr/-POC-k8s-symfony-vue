#!/bin/bash

echo "Mise en place des droits pour www-data"
chown -Rf www-data:www-data /code/var

echo "Démarrage du service"

nginx -g "daemon off;" &
php-fpm