FROM debian:buster

RUN apt-get update && \
    apt-get upgrade -y

RUN apt-get install nginx openssl nano curl -y

RUN mkdir /etc/nginx/ssl && \
    chmod 700 /etc/nginx/ssl && \
    openssl req -x509 -nodes -days 365 -newkey rsa:4096 -keyout /etc/nginx/ssl/inception.key -out /etc/nginx/ssl/inception.cert -subj '/CN=MA'

RUN rm -f /etc/nginx/sites-enabled/default

COPY config/inception.conf /etc/nginx/sites-enabled/inception.php

COPY tools/setup_nginx.sh /tmp/setup_nginx.sh

RUN chmod +x /tmp/setup_nginx.sh

EXPOSE 443

ENTRYPOINT [ "bash", "/tmp/setup_nginx.sh" ]
