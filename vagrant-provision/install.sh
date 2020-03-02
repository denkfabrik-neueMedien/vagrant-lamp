#!/usr/bin/env bash

# basics
sudo apt-get update
sudo apt-get install -y imagemagick git curl

# apache
sudo apt-get install -y apache2
sudo a2enmod filter deflate mime expires rewrite headers
sudo service apache2 restart

# mysql
MYSQL_USER="root"
MYSQL_PASS="geheim"
debconf-set-selections <<< 'mysql-server mysql-server/root_password password geheim'
debconf-set-selections <<< 'mysql-server mysql-server/root_password_again password geheim'
sudo apt-get install -y mysql-server
mysql -u root -pgeheim -e "GRANT ALL PRIVILEGES ON *.* TO 'root'@'%' IDENTIFIED BY 'geheim'; FLUSH privileges;"
sudo sed -i "s/.*bind-address.*/bind-address = 0.0.0.0/" /etc/mysql/mysql.conf.d/mysqld.cnf
sudo service mysql restart

# php
sudo add-apt-repository ppa:ondrej/php
sudo apt-get update
sudo apt-get install -y libapache2-mod-php7.2 \
                        php7.2 \
                        php7.2-cli \
                        php7.2-curl \
                        php7.2-gd \
                        php7.2-imap \
                        php7.2-intl \
                        php7.2-mbstring \
                        php7.2-mysql \
                        php7.2-tidy \
                        php7.2-xml \
                        php7.2-xsl \
                        php7.2-zip \
                        php7.2-opcache \
                        php7.2-xdebug \
                        php-imagick \
                        php-oauth \
                        php-pear
a2enmod rewrite

# i18n
sudo locale-gen de_DE.UTF-8
sudo update-locale LANG=de_DE.UTF-8