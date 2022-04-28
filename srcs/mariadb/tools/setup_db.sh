#!/bin/bash

if [ ! -d "/var/lib/mysql/mysql" ]; then

/usr/bin/mysql_install_db -user=mysql --datadir='/var/lib/mysql' > /dev/null

/etc/init.d/mysql start

expect -c "
set timeout 10
spawn /usr/bin/mysql_secure_installation
expect \"Enter current password for root (enter for none):\"
send \"\r\"
expect \"Set root password?\"
send \"n\r\"
expect \"Remove anonymous users?\"
send \"y\r\"
expect \"Disallow root login remotely?\"
send \"y\r\"
expect \"Remove test database and access to it?\"
send \"y\r\"
expect \"Reload privilege tables now?\"
send \"y\r\"
expect eof
" > /dev/null

echo "mysql << EOF
USE mysql;
create database $MYSQL_DATABASE;
CREATE USER '$MYSQL_USER'@'%' IDENTIFIED BY '$MYSQL_PASSWORD';
GRANT ALL PRIVILEGES ON $MYSQL_DATABASE . * TO '$MYSQL_USER'@'%';
FLUSH PRIVILEGES;
EOF" > /tmp/database_setup.sh
chmod 700 /tmp/database_setup.sh
chmod +x /tmp/database_setup.sh
/tmp/database_setup.sh  2>&1 > /tmp/loglol
rm -f /tmp/database_setup

fi

/etc/init.d/mysql stop

# You can start the MariaDB daemon with:
echo "starting mysql..."
exec /usr/bin/mysqld_safe --user=mysql --datadir='/var/lib/mysql'
