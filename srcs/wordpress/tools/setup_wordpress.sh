
#!/bin/bash
if [ ! -f "/var/www/wordpress/wp-config.php" ]; then

mkdir -p /var/www/wordpress
tar xzf /tmp/latest.tar.gz --strip-components=1 -C /var/www/wordpress/

echo "<?php
define( 'DB_NAME', '$MYSQL_DATABASE' );
define( 'DB_USER', '$MYSQL_USER' );
define( 'DB_PASSWORD', '$MYSQL_PASSWORD' );
define( 'DB_HOST', '$WORDPRESS_DB_HOST' );
define( 'DB_CHARSET', 'utf8' );
define( 'DB_COLLATE', '' );
define( 'WP_REDIS_HOST', '$WORDPRESS_REDIS_HOST' );
define( 'WP_REDIS_PORT', 6379 );
define( 'WP_REDIS_TIMEOUT', 1 );
define( 'WP_REDIS_READ_TIMEOUT', 1 );
define( 'WP_REDIS_DATABASE', 0 );
" >  /var/www/wordpress/wp-config.php

curl -s https://api.wordpress.org/secret-key/1.1/salt/ >> /var/www/wordpress/wp-config.php

echo "
\$table_prefix = '$WORDPRESS_TABLE_PREFIX';

define( 'WP_DEBUG', false );
if ( ! defined( 'ABSPATH' ) ) {
	define( 'ABSPATH', __DIR__ . '/' );
}
require_once ABSPATH . 'wp-settings.php';

" >> /var/www/wordpress/wp-config.php

OUTPUT="Can't connect"
while [[ $OUTPUT == *"Can't connect"* ]]
do
    OUTPUT=$(mariadb -h$WORDPRESS_DB_HOST -u$MYSQL_USER -p$MYSQL_PASSWORD $MYSQL_DATABASE <  /tmp/test.sql 2>&1)
	sleep 1
done
sleep 5
wp core install --allow-root --url=$DOMAIN_NAME --title=inception --admin_user=$WORDPRESS_ADMIN_USER --admin_password=$WORDPRESS_ADMIN_PASS --admin_email=$WORDPRESS_ADMIN_MAIL --skip-email --path=/var/www/wordpress/
wp user create $WORDPRESS_AUTHOR_USER $WORDPRESS_AUTHOR_MAIL --user_pass=$WORDPRESS_AUTHOR_PASS --role=author --allow-root --url=$DOMAIN_NAME --path=/var/www/wordpress/ --porcelain
wp plugin install redis-cache --activate --allow-root --path=/var/www/wordpress/
fi
wp redis enable --allow-root --path=/var/www/wordpress/

chown -R www-data:www-data  /var/www/wordpress
chown -R 777 /var/www/wordpress/*
chmod -R 777 /var/www/wordpress/*

echo "starting php-fpm:wordpress..."
/usr/sbin/php-fpm7.3 -FR