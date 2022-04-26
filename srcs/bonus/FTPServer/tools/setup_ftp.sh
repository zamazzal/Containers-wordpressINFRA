#!/bin/bash

mkdir -p /var/run/vsftpd/empty
touch /etc/vsftpd.chroot_list /etc/vsftpd/chroot_list
echo $FTP_USER | tee -a /etc/vsftpd.userlist

if id "$FTP_USER" &>/dev/null; then
    echo 'user found'
else
    adduser $FTP_USER --disabled-password
    echo "$FTP_USER:$FTP_PASSWORD" | /usr/sbin/chpasswd > /dev/null
    chown -R $FTP_USER:$FTP_USER /home/wordpress
    chmod a-w -R /home/wordpress
    chmod -R 775 /home/wordpress
    usermod -d /home/wordpress/ $FTP_USER
fi

/usr/sbin/vsftpd /etc/vsftpd.conf