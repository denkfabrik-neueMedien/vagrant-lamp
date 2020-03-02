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
sudo apt-get install -y libapache2-mod-php5.6 \
                        php5.6 \
                        php5.6-cli \
                        php5.6-curl \
                        php5.6-gd \
                        php5.6-imap \
                        php5.6-intl \
                        php5.6-mbstring \
                        php5.6-mcrypt \
                        php5.6-mysql \
                        php5.6-tidy \
                        php5.6-xml \
                        php5.6-xsl \
                        php5.6-zip \
                        php5.6-opcache \
                        php5.6-xdebug \
                        php-imagick \
                        php-oauth \
                        php-pear
a2enmod rewrite

# i18n
sudo locale-gen de_DE.UTF-8
sudo update-locale LANG=de_DE.UTF-8