#!/bin/bash
sed -i 's@{{DomainName}}@'"$DOMAIN_NAME"'@' /etc/nginx/sites-enabled/inception.conf
sed -i 's@{{CertifPATH}}@'"$CERTS"'@' /etc/nginx/sites-enabled/inception.conf
sed -i 's@{{KeyPATH}}@'"$CERTS_KEY"'@' /etc/nginx/sites-enabled/inception.conf

sed -i 's@{{DomainName}}@'"$ADMINER_DOMAIN_NAME"'@' /etc/nginx/sites-enabled/adminer.conf
sed -i 's@{{CertifPATH}}@'"$CERTS"'@' /etc/nginx/sites-enabled/adminer.conf
sed -i 's@{{KeyPATH}}@'"$CERTS_KEY"'@' /etc/nginx/sites-enabled/adminer.conf


sed -i 's@{{DomainName}}@'"$STATICWEB_DOMAIN_NAME"'@' /etc/nginx/sites-enabled/staticweb.conf
sed -i 's@{{CertifPATH}}@'"$CERTS"'@' /etc/nginx/sites-enabled/staticweb.conf
sed -i 's@{{KeyPATH}}@'"$CERTS_KEY"'@' /etc/nginx/sites-enabled/staticweb.conf

# start nginx
echo "127.0.0.1	$DOMAIN_NAME" >> /etc/hosts
echo "127.0.0.1	$ADMINER_DOMAIN_NAME" >> /etc/hosts
echo "127.0.0.1	$STATICWEB_DOMAIN_NAME" >> /etc/hosts

echo "starting nginx..."
nginx -g 'daemon off;'