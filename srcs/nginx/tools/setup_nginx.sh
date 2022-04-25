#!/bin/bash
sed -i 's@{{DomainName}}@'"$DOMAIN_NAME"'@' /etc/nginx/sites-enabled/inception.php
sed -i 's@{{CertifPATH}}@'"$CERTS"'@' /etc/nginx/sites-enabled/inception.php
sed -i 's@{{KeyPATH}}@'"$CERTS_KEY"'@' /etc/nginx/sites-enabled/inception.php
# start nginx
nginx -g 'daemon off;'