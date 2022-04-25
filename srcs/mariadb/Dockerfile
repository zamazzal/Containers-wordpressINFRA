FROM debian:buster

RUN apt-get update && apt-get upgrade -y

RUN apt-get install mariadb-server expect -y

RUN sed -i "s|.*bind-address\s*=.*|bind-address=0.0.0.0|g" /etc/mysql/mariadb.conf.d/50-server.cnf

COPY tools/setup_db.sh /tmp/setup_db.sh
RUN chmod +x /tmp/setup_db.sh

EXPOSE 3306

ENTRYPOINT [ "bash", "/tmp/setup_db.sh" ]
