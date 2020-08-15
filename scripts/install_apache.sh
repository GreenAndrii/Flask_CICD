#!/bin/bash
echo "********************************** START PREPARE ENVIRONMENT *******************************"
wget -q --read-timeout=0.0 --waitretry=5 --tries=400 --background https://ipv4.cloudns.net/api/dynamicURL/?q=MjcwMTMxOToxOTkxOTE0MDY6MWZmOWY3OThkMjNhNDBjODcyYThmZjEyYjY3ZTc0OGVjZmM0NjJkZmE3NjNlNDJiMGUyZjIwNGJmZDI0MGNkYw
sudo apt-get update
echo "Install requirements..."
sudo apt-get -y install apache2 mysql-server php libapache2-mod-php php-xml php-gd php-mysql php-mbstring php-zip php-curl php-intl unzip

echo "Set rewrite mode ON"
sudo a2enmod rewrite

echo "Create Database for Prestashop"
sudo mysql -uroot -e "DROP DATABASE IF EXISTS prestashop; CREATE DATABASE prestashop; CREATE USER IF NOT EXISTS prestashop@localhost IDENTIFIED BY 'admin123'; GRANT ALL PRIVILEGES on prestashop.* to prestashop@localhost IDENTIFIED BY 'admin123'; FLUSH PRIVILEGES;"

echo "Restart services Apache and MySQL"
sudo systemctl restart apache2.service
sudo systemctl restart mysql.service
