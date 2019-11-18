
#!/bin/bash
set -x
# Actualizar PC
apt-get update
# Instalar nginx
apt-get install nginx -y
# instalación del paquete php-fpm
apt-get install php-fpm php-mysql

# Instalamos git
apt-get install git -y

# Instalamos la aplicacion
cd /var/www/html
rm -rf iaw-practica-lamp
git clone https://github.com/josejuansanchez/iaw-practica-lamp.git
chown www-data:www-data * -R

# configurar el archivo config.php
cd /var/www/html/iaw-practica-lamp/src/
sed -i "s/localhost/35.172.114.64/" config.php

# configurar el archivo php-fpm
cd /etc/php/7.2/fpm/
sed -i "s/;cgi.fix_pathinfo=1/cgi.fix_pathinfo=0/" php.ini

# configurar nginx para usar php-fpm
cd ~
cp default/default /etc/nginx/sites-available/
systemctl restart nginx

# configurar nginkx para acceder php
cd ~
cp info.php/info.php  /var/www/html/