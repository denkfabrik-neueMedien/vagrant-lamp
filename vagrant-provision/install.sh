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
sudo apt-get install -y libapache2-mod-php7.1 \
                        php7.1 \
                        php7.1-cli \
                        php7.1-curl \
                        php7.1-gd \
                        php7.1-imap \
                        php7.1-intl \
                        php7.1-mbstring \
                        php7.1-mcrypt \
                        php7.1-mysql \
                        php7.1-tidy \
                        php7.1-xml \
                        php7.1-xsl \
                        php7.1-zip \
                        php7.1-opcache \
                        php7.1-xdebug \
                        php-imagick \
                        php-oauth \
                        php-pear
a2enmod rewrite

# i18n
sudo locale-gen de_DE.UTF-8
sudo update-locale LANG=de_DE.UTF-8