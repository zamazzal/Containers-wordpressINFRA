
#!/bin/bash
if [ ! -f "/var/www/adminer/.ready" ]; then
wget "http://www.adminer.org/latest.php" -O /var/www/adminer/index.php
touch /var/www/adminer/.ready
fi
chown -R www-data:www-data /var/www/adminer/
chmod 755 /var/www/adminer/

echo "starting php-fpm:adminer..."
/usr/sbin/php-fpm7.3 -FR