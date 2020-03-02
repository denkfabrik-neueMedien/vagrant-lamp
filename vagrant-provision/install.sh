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
sudo apt-get install -y libapache2-mod-php7.3 \
                        php7.3 \
                        php7.3-cli \
                        php7.3-curl \
                        php7.3-gd \
                        php7.3-imap \
                        php7.3-intl \
                        php7.3-mbstring \
                        php7.3-mysql \
                        php7.3-tidy \
                        php7.3-xml \
                        php7.3-xsl \
                        php7.3-zip \
                        php7.3-opcache \
                        php7.3-xdebug \
                        php-imagick \
                        php-oauth \
                        php-pear
# mod-rewrite                        
a2enmod rewrite
sudo sed -i '/<Directory \/var\/www\/>/,/<\/Directory>/ s/AllowOverride None/AllowOverride All/' /etc/apache2/apache2.conf

# i18n
sudo locale-gen de_DE.UTF-8
sudo update-locale LANG=de_DE.UTF-8