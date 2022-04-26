#!/bin/bash

mkdir -p /var/run/vsftpd/empty
touch /etc/vsftpd.chroot_list /etc/vsftpd/chroot_list
if id "$FTP_USER" &>/dev/null; then
    echo 'user found'
else
    adduser $FTP_USER --disabled-password
    echo "$FTP_USER:$FTP_PASSWORD" | /usr/sbin/chpasswd > /dev/null
    chown -R $FTP_USER:$FTP_USER /home/wordpress
    usermod -d /home/wordpress/ $FTP_USER
fi

/usr/sbin/vsftpd /etc/vsftpd.conf