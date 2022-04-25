
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

cp /tmp/index.html /var/www/wordpress/index.html
fi

chown -R www-data:www-data  /var/www/wordpress
chown -R 755 /var/www/wordpress/*

/usr/sbin/php-fpm7.3 -FR