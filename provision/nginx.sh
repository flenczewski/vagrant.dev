#!/bin/bash

# Nginx Configuration
echo "Configuring Nginx"
cp /var/www/provision/config/nginx.conf /etc/nginx/nginx.conf > /dev/null
cp /var/www/provision/config/dynamic_vhost /etc/nginx/sites-available/dynamic_vhost > /dev/null
ln -s /etc/nginx/sites-available/dynamic_vhost /etc/nginx/sites-enabled/dynamic_vhost

rm -rf /etc/nginx/sites-available/default

# Restart Nginx for the config to take effect
service nginx restart > /dev/null
