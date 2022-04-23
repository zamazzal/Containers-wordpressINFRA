FROM debian:buster

RUN apt-get update && \
    apt-get upgrade -y

RUN apt-get install nginx openssl nano curl -y

RUN mkdir /etc/nginx/ssl && \
    chmod 700 /etc/nginx/ssl && \
    openssl req -x509 -nodes -days 365 -newkey rsa:4096 -keyout /etc/nginx/ssl/inception.key -out /etc/nginx/ssl/inception.cert -subj '/CN=MA'

RUN rm -f /etc/nginx/sites-enabled/default

COPY config/inception.conf /etc/nginx/sites-enabled/inception.php

RUN sed -i "s|.*server_name\s*=.*|server_name=$DOMAIN_NAME|g" /etc/nginx/sites-enabled/inception.php
RUN sed -i "s|.*ssl_certificate\s*=.*|server_name=$CERT|g" /etc/nginx/sites-enabled/inception.php
RUN sed -i "s|.*ssl_certificate_key\s*=.*|server_name=$CERT_KEY|g" /etc/nginx/sites-enabled/inception.php

EXPOSE 443

ENTRYPOINT ["nginx", "-g", "daemon off;"]