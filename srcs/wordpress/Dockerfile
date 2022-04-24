FROM debian:buster

RUN apt-get update && \
    apt-get upgrade -y

RUN apt-get install php7.3 php7.3-cli php7.3-common php7.3-gmp php7.3-imap php7.3-mysql php7.3-gd php7.3-xml php7.3-curl php7.3-intl php7.3-fpm php7.3-mbstring php7.3-soap php7.3-xmlrpc php7.3-zip zip curl wget tar -y

RUN sed -i "s|.*cgi.fix_pathinfo\s*=.*|cgi.fix_pathinfo=0|g" /etc/php/7.3/fpm/php.ini && \
    sed -i "s|.*date.timezone\s*=.*|date.timezone = Africa/Casablanca|g" /etc/php/7.3/fpm/php.ini

COPY config/inception.conf /etc/php/7.3/fpm/pool.d/www.conf

RUN mkdir -p /run/php/

RUN wget https://wordpress.org/latest.tar.gz -P /tmp

COPY tools/setup_wordpress.sh /tmp/setup_wordpress.sh

COPY config/index.html /tmp/index.html

RUN chmod +x /tmp/setup_wordpress.sh

EXPOSE 9000

ENTRYPOINT [ "sh", "/tmp/setup_wordpress.sh" ]