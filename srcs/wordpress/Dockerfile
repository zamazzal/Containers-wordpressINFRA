FROM debian:buster

RUN apt-get update && \
    apt-get upgrade -y

RUN apt-get install php7.3 php7.3-cli php7.3-mysql php7.3-gd php7.3-xml php7.3-fpm zip wget tar -y

RUN apt-get install mariadb-client -y

RUN sed -i "s|.*cgi.fix_pathinfo\s*=.*|cgi.fix_pathinfo=0|g" /etc/php/7.3/fpm/php.ini

RUN sed -i "s|.*date.timezone\s*=.*|date.timezone = Africa/Casablanca|g" /etc/php/7.3/fpm/php.ini



CMD [ "/usr/bin/tail", "-f" ]