#!/bin/bash
sed -i 's@{{DomainName}}@'"$DOMAIN_NAME"'@' /etc/nginx/sites-enabled/inception.conf
sed -i 's@{{CertifPATH}}@'"$CERTS"'@' /etc/nginx/sites-enabled/inception.conf
sed -i 's@{{KeyPATH}}@'"$CERTS_KEY"'@' /etc/nginx/sites-enabled/inception.conf

sed -i 's@{{DomainName}}@'"$DOMAIN_NAME"'@' /etc/nginx/sites-enabled/adminer.conf
sed -i 's@{{CertifPATH}}@'"$CERTS"'@' /etc/nginx/sites-enabled/adminer.conf
sed -i 's@{{KeyPATH}}@'"$CERTS_KEY"'@' /etc/nginx/sites-enabled/adminer.conf
# start nginx
echo "127.0.0.1	$DOMAIN_NAME" >> /etc/hosts
echo "127.0.0.1	adminer-$DOMAIN_NAME" >> /etc/hosts
echo "127.0.0.1	static-$DOMAIN_NAME" >> /etc/hosts

nginx -g 'daemon off;'