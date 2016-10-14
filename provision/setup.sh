#!/bin/bash

echo "Provisioning virtual machine..."
apt-get update -y
apt-get upgrade -y

apt-get install htop -y
apt-get install mc -y

# Git
echo "Installing Git"
apt-get install git -y > /dev/null

# Nginx
echo "Installing Nginx"
apt-get install nginx -y > /dev/null

# PHP
echo "Updating PHP repository"
apt-get install python-software-properties build-essential -y > /dev/null
add-apt-repository ppa:ondrej/php5 -y > /dev/null
apt-get update > /dev/null

echo "Installing PHP"
apt-get install php5-common php5-dev php5-cli php5-fpm -y > /dev/null

echo "Installing PHP extensions"
apt-get install curl php5-curl php5-gd php5-mcrypt php5-mysql -y > /dev/null

echo "Installing Composer"
php -r "copy('https://getcomposer.org/installer', 'composer-setup.php');"
php -r "if (hash_file('SHA384', 'composer-setup.php') === 'e115a8dc7871f15d853148a7fbac7da27d6c0030b848d9b3dc09e2a0388afed865e6a3d6b3c0fad45c48e2b5fc1196ae') { echo 'Installer verified'; } else { echo 'Installer corrupt'; unlink('composer-setup.php'); } echo PHP_EOL;"
php composer-setup.php
php -r "unlink('composer-setup.php');"
mv composer.phar /usr/local/bin/composer

# Redis
echo "Instaling Redis"
apt-get install redis-server -y > /dev/null

# MySQL 
#echo "Preparing MySQL"
#apt-get install debconf-utils -y > /dev/null
#debconf-set-selections <<< "mysql-server mysql-server/root_password password 1234"
#debconf-set-selections <<< "mysql-server mysql-server/root_password_again password 1234"

#echo "Installing MySQL"
#apt-get install mysql-server -y > /dev/null

echo "Installing RabbitMQ"
sudo echo "deb http://www.rabbitmq.com/debian testing main" >> /etc/apt/sources.list
wget https://www.rabbitmq.com/rabbitmq-signing-key-public.asc
sudo apt-key add rabbitmq-signing-key-public.asc
sudo apt-get update
sudo apt-get install rabbitmq-server -y
sudo rabbitmq-plugins enable rabbitmq_management
sudo rabbitmq-server restart

echo "Finished provisioning."

#echo "address=/.dev/127.0.0.1" >> /etc/dnsmasq.conf